# SkillSpector Inference Lab Scan Runbook

This runbook explains how to run SkillSpector scans from the custom `skillspector-inference-lab-integration` branch with the Inference Lab OpenAI-compatible endpoint.

## 1. Clone The Repository

Clone the fork or upstream repository that contains the custom branch.

```bash
git clone https://github.com/kushal2705/SkillSpector.git
cd SkillSpector
```

If you already have the repository, update it instead:

```bash
git fetch --all --prune
```

## 2. Check Out The Custom Branch

```bash
git checkout skillspector-inference-lab-integration
```

If the branch is only on `origin`:

```bash
git checkout -b skillspector-inference-lab-integration origin/skillspector-inference-lab-integration
```

Confirm the branch:

```bash
git branch --show-current
```

Expected output:

```text
skillspector-inference-lab-integration
```

## 3. Create And Activate A Python Environment

SkillSpector requires Python `>=3.12,<3.15`.

With `uv`:

```bash
uv venv .venv --python 3.12
source .venv/bin/activate
```

Without `uv`:

```bash
python3.12 -m venv .venv
source .venv/bin/activate
```

Confirm Python:

```bash
python --version
```

## 4. Install Dependencies

For normal scan usage from source:

```bash
make install
```

For development and tests:

```bash
make install-dev
```

Equivalent direct install:

```bash
python -m pip install -e ".[dev]"
```

Confirm the CLI works:

```bash
python -m skillspector.cli --help
```

## 5. Configure `.env`

Create `.env` from the example file:

```bash
cp .env.example .env
```

Edit `.env` and set the Inference Lab values. Do not commit `.env` because it contains secrets.

```bash
export SKILLSPECTOR_PROVIDER=openai
export OPENAI_API_KEY=<your-api-key>
export OPENAI_BASE_URL=https://api-demo.eglb.intel.com/v1
export SKILLSPECTOR_MODEL=deepseek-v4-flash-0731
export SKILLSPECTOR_MODEL_REGISTRY=./model_registry.yaml
export SKILLSPECTOR_MAX_LLM_CONCURRENCY=1
export SKILLSPECTOR_MAX_BATCH_INPUT_TOKENS=4096
export SKILLSPECTOR_REASONING_EFFORT=low
```

For AMD Instinct scans or any repository with large generated cache artifacts, also set:

```bash
export SKILLSPECTOR_LLM_EXCLUDE_GLOBS=data/recipes_cache.json
```

This excludes matching files from external LLM calls only. They remain available to local/static analyzers.

## 6. Load Environment Variables

Before running a scan in a shell, source `.env`:

```bash
set -a
source .env
set +a
```

Keep the virtual environment active:

```bash
source .venv/bin/activate
```

## 7. Verify Endpoint Access

Run a lightweight model-list check before starting long scans:

```bash
curl -s "$OPENAI_BASE_URL/models" \
  -H "Authorization: Bearer $OPENAI_API_KEY" | jq
```

Confirm the response includes:

```text
deepseek-v4-flash-0731
```

If this request times out or returns HTTP `000`, fix network or endpoint access before running scans.

## 8. Run A Single Skill Scan

Create an output directory:

```bash
mkdir -p scan-results/deepseek-v4-flash-0731
```

Run a scan:

```bash
python -m skillspector.cli scan \
  /path/to/skill/ \
  --format markdown \
  --output scan-results/deepseek-v4-flash-0731/<skill-name>.md \
  --verbose \
  2>&1 | tee scan-results/deepseek-v4-flash-0731/<skill-name>.debug.log
```

Example:

```bash
python -m skillspector.cli scan \
  /Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/llamacpp-xpu-run/ \
  --format markdown \
  --output scan-results/deepseek-v4-flash-0731/llamacpp-xpu-run.md \
  --verbose \
  2>&1 | tee scan-results/deepseek-v4-flash-0731/llamacpp-xpu-run.debug.log
```

The Markdown report contains the scan findings. The debug log contains analyzer progress, LLM errors, retry messages, and total scan time.

## 9. Run Intel Batch Scans

Use the included Intel helper script:

```bash
./scripts/scan_remaining_intel_xpu_skills.sh
```

Run selected skills:

```bash
./scripts/scan_remaining_intel_xpu_skills.sh --force \
  llamacpp-xpu-run \
  vllm-xpu-run
```

Preview without running:

```bash
./scripts/scan_remaining_intel_xpu_skills.sh --dry-run
```

## 10. Run AMD Batch Scans

Use the AMD helper script:

```bash
./scripts/scan_amd_skills.sh
```

Run selected skills:

```bash
./scripts/scan_amd_skills.sh --force \
  serving-llms-on-instinct \
  tracelens-analysis-orchestrator
```

Preview without running:

```bash
./scripts/scan_amd_skills.sh --dry-run
```

AMD results are written to:

```text
scan-results/amd/deepseek-v4-flash-0731/
```

The batch status file is:

```text
scan-results/amd/deepseek-v4-flash-0731/status.tsv
```

## 11. Interpret Exit Codes

| Exit Code | Meaning |
|---:|---|
| `0` | Scan completed and did not exceed the configured risk threshold. |
| `1` | Scan completed, but findings or risk threshold caused a nonzero result. This is not an infrastructure failure. |
| `2+` | Scan execution failed or was incomplete. Check the debug log and report completeness section. |

For batch scans, `0` and `1` are treated as completed scans. Only `2+` is treated as failed execution.

## 12. Understand The Custom Settings

| Setting | Purpose |
|---|---|
| `SKILLSPECTOR_MAX_LLM_CONCURRENCY=1` | Serializes LLM calls to avoid overloading a rate-limited endpoint. |
| `SKILLSPECTOR_MAX_BATCH_INPUT_TOKENS=4096` | Splits large files into smaller LLM requests to reduce output-token-limit failures. |
| `SKILLSPECTOR_LLM_EXCLUDE_GLOBS=data/recipes_cache.json` | Keeps large generated cache files out of external LLM calls while preserving local/static analysis. |
| `SKILLSPECTOR_MODEL_REGISTRY=./model_registry.yaml` | Provides context-window and output-token metadata for custom models. |
| `SKILLSPECTOR_REASONING_EFFORT=low` | Requests lower reasoning effort where the provider supports it, reducing latency and verbosity. |

This branch also raises the workflow deadline to `4800` seconds for long-running scans.

## 13. Troubleshooting

If the endpoint is unreachable:

```bash
curl --max-time 20 -sS -o /dev/null \
  -w 'HTTP %{http_code} in %{time_total}s\n' \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  "$OPENAI_BASE_URL/models"
```

Expected success is HTTP `200`. HTTP `000` usually means network timeout or connection failure.

If a scan hits the model output-token limit, lower the batch input cap:

```bash
export SKILLSPECTOR_MAX_BATCH_INPUT_TOKENS=2048
```

If a scan spends too long on generated cache files, add an LLM-only exclusion:

```bash
export SKILLSPECTOR_LLM_EXCLUDE_GLOBS=data/recipes_cache.json
```

If a scan exits with `1`, open the Markdown report. The scan likely completed and found security issues.

If a scan exits with `2`, inspect the completeness section and debug log:

```bash
tail -n 80 scan-results/deepseek-v4-flash-0731/<skill-name>.debug.log
```

Look for messages such as:

```text
length limit was reached
Request timed out
Connection error
runtime_limit
Error code: 400
Error code: 500
```

## 14. Security Notes

- Never commit `.env` or API keys.
- Rotate any API key that appears in shared logs, screenshots, tickets, or chat.
- SkillSpector scans source artifacts. The normal `skillspector scan` command does not execute the target skill, run its harness, launch Docker containers, or benchmark runtime behavior.
