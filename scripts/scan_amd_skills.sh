#!/usr/bin/env bash
set -uo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
skills_root=${SKILLS_ROOT:-/Users/kmittal/Code/GTM/amd-skills/skills}
results_root=${RESULTS_ROOT:-${repo_root}/scan-results/amd/deepseek-v4-flash-0731}
env_file=${ENV_FILE:-${repo_root}/.env}
python=${PYTHON:-${repo_root}/.venv/bin/python}
status_file=${results_root}/status.tsv
force=0
dry_run=0
selected_skills=()

usage() {
  cat <<'EOF'
Usage: scripts/scan_amd_skills.sh [OPTIONS] [SKILL ...]

Scans all AMD skills. When one or more skill names are provided, scans only
those selected skills. Completed scans with existing reports and logs are
skipped on subsequent runs.

Examples:
  scripts/scan_amd_skills.sh
  scripts/scan_amd_skills.sh local-ai-use serving-llms-on-instinct
  scripts/scan_amd_skills.sh --force tracelens-analysis-orchestrator

Options:
  --force    Rescan selected skills even when they were previously completed.
  --dry-run  Print the skills that would be scanned without running SkillSpector.
  --help     Show this help.

Environment overrides:
  SKILLS_ROOT  Source directory containing the skill directories.
  RESULTS_ROOT Destination directory for Markdown reports and debug logs.
  ENV_FILE     Environment file to source (default: repository .env).
  PYTHON       Python executable (default: repository .venv/bin/python).
EOF
}

while (($#)); do
  case "$1" in
    --force) force=1 ;;
    --dry-run) dry_run=1 ;;
    --help|-h)
      usage
      exit 0
      ;;
    --*)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
    *) selected_skills+=("$1") ;;
  esac
  shift
done

if [[ ! -d "$skills_root" ]]; then
  printf 'Skills directory not found: %s\n' "$skills_root" >&2
  exit 2
fi

if [[ ! -x "$python" ]]; then
  printf 'Python executable not found: %s\n' "$python" >&2
  exit 2
fi

if [[ ! -f "$env_file" ]]; then
  printf 'Environment file not found: %s\n' "$env_file" >&2
  exit 2
fi

if ((${#selected_skills[@]})); then
  for skill in "${selected_skills[@]}"; do
    if [[ ! -d "$skills_root/$skill" ]]; then
      printf 'Unknown skill: %s\n' "$skill" >&2
      exit 2
    fi
  done
fi

skill_is_selected() {
  local candidate=$1
  local selected_skill
  for selected_skill in "${selected_skills[@]}"; do
    if [[ "$selected_skill" == "$candidate" ]]; then
      return 0
    fi
  done
  return 1
}

mkdir -p "$results_root"
if [[ ! -f "$status_file" ]]; then
  printf 'skill\texit_code\n' > "$status_file"
fi

set -a
# shellcheck disable=SC1090
source "$env_file"
set +a

scan_completed() {
  local skill=$1
  awk -F '\t' -v skill="$skill" '
    $1 == skill { code = $2 }
    END { exit !(code == "0" || code == "1") }
  ' "$status_file"
}

completed=0
failed=0
skipped=0

for skill_dir in "$skills_root"/*/; do
  [[ -d "$skill_dir" ]] || continue
  skill=$(basename "$skill_dir")

  if ((${#selected_skills[@]})) && ! skill_is_selected "$skill"; then
    continue
  fi

  report_path=${results_root}/${skill}.md
  log_path=${results_root}/${skill}.debug.log

  if ((force == 0)) && [[ -s "$report_path" && -s "$log_path" ]] && scan_completed "$skill"; then
    printf 'SKIP %s (previously completed)\n' "$skill"
    ((skipped += 1))
    continue
  fi

  if ((dry_run)); then
    printf 'SCAN %s\n' "$skill"
    continue
  fi

  printf '\n===== Scanning %s =====\n' "$skill"
  "$python" -m skillspector.cli scan "$skill_dir" \
    --format markdown \
    --output "$report_path" \
    --verbose \
    2>&1 | tee "$log_path"
  exit_code=${PIPESTATUS[0]}
  printf '%s\t%s\n' "$skill" "$exit_code" >> "$status_file"

  if ((exit_code <= 1)); then
    ((completed += 1))
  else
    ((failed += 1))
  fi
  printf '===== Finished %s (exit %s) =====\n' "$skill" "$exit_code"
done

if ((dry_run)); then
  exit 0
fi

printf '\nBatch finished: %d completed, %d skipped, %d failed\n' "$completed" "$skipped" "$failed"
printf 'Status: %s\n' "$status_file"
((failed == 0))