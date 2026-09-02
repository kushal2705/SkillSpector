#!/usr/bin/env bash
set -uo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
skills_root=${SKILLS_ROOT:-/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills}
results_root=${RESULTS_ROOT:-${repo_root}/scan-results/deepseek-v4-flash-0731}
env_file=${ENV_FILE:-${repo_root}/.env}
python=${PYTHON:-${repo_root}/.venv/bin/python}
status_file=${results_root}/status.tsv
force=0
dry_run=0
selected_skills=()

usage() {
  cat <<'EOF'
Usage: scripts/scan_remaining_intel_xpu_skills.sh [OPTIONS] [SKILL ...]

Scans all Intel XPU skills except cuda-to-xpu-migration and llamacpp-xpu-run.
When one or more skill names are provided, scans only those selected skills.
Successful scans with existing reports and logs are skipped on subsequent runs.

Examples:
  scripts/scan_remaining_intel_xpu_skills.sh
  scripts/scan_remaining_intel_xpu_skills.sh xpu-container-run xpu-port
  scripts/scan_remaining_intel_xpu_skills.sh --force model-config-recommend

Options:
  --force    Rescan all 18 skills, including previously successful scans.
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
    *)
      selected_skills+=("$1")
      ;;
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
    if [[ "$skill" == "cuda-to-xpu-migration" || "$skill" == "llamacpp-xpu-run" ]]; then
      printf 'Skill is excluded because it was already scanned separately: %s\n' "$skill" >&2
      exit 2
    fi
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

scan_succeeded() {
  local skill=$1
  awk -F '\t' -v skill="$skill" '
    $1 == skill { code = $2 }
    END { exit !(code == "0") }
  ' "$status_file"
}

completed=0
failed=0
skipped=0

for skill_dir in "$skills_root"/*/; do
  [[ -d "$skill_dir" ]] || continue
  skill=$(basename "$skill_dir")

  case "$skill" in
    cuda-to-xpu-migration|llamacpp-xpu-run) continue ;;
  esac

  if ((${#selected_skills[@]})) && ! skill_is_selected "$skill"; then
    continue
  fi

  report_path=${results_root}/${skill}.md
  log_path=${results_root}/${skill}.debug.log

  if ((force == 0)) && [[ -s "$report_path" && -s "$log_path" ]] && scan_succeeded "$skill"; then
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

  if ((exit_code == 0)); then
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