# SkillSpector Security Report

**Skill:** xpu-runtime-preflight  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/xpu-runtime-preflight`  
**Scanned:** 2026-09-02 02:35:55 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 75/100 |
| Severity | HIGH |
| Recommendation | DO NOT INSTALL |

## Components (2)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 146 | No |
| `scripts/check_runtime_preflight.sh` | shell | 579 | Yes |

## Issues (6)

### 🔴 HIGH: PE3

**Location:** `SKILL.md:47`  
**Confidence:** 80%  

**Message:** The example invokes `--env-file .env`, which strongly implies the script reads an environment file. `.env` files routinely contain secrets such as proxy credentials, API tokens, or registry passwords. Passing that file to a shell-based preflight script creates multiple risks: command-line arguments may be visible to other local processes; verbose logging could dump the file contents into `preflight.log` or `SUMMARY.md`; and if the script is compromised, the secrets could be exfiltrated. Even though the skill is described as read-only, processing `.env` is a credential-handling operation that exceeds the apparent diagnostic goal.

**Remediation:** Avoid accepting an entire `.env` file. Instead, read only non-secret parameters individually (e.g., `--proxy-url`) or rely on already-set environment variables. Ensure all script output is scrubbed/redacted, never print environment variable values, and make clear in documentation that `.env` must not contain secrets. If secrets must be used, pass them securely via a protected environment variable and prevent them from appearing in logs, process lists, or generated artifacts.

---

### 🔴 HIGH: PE5

**Location:** `scripts/check_runtime_preflight.sh:429`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `scripts/check_runtime_preflight.sh:520`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🟡 MEDIUM: LP3

**Location:** `SKILL.md:1`  
**Confidence:** 70%  

**Message:** The skill frontmatter does not declare any `permissions` or `allowed-tools` scope, yet the documented usage requires invoking a shell script and optionally consuming environment files. In an agentic framework this means the agent may fall back to broad, implicit shell/environment capabilities. If the referenced script or skill content is ever tampered with, an attacker could leverage the agent’s privileges to run arbitrary commands. The intended behavior is read-only diagnostics, so the immediate risk is moderate, but the missing guardrail weakens least-privilege enforcement.

**Remediation:** Add explicit `permissions` or `allowed-tools` metadata to the skill, limiting it to read-only commands such as `xpu-smi`, `docker info`, `df`, `stat`, and targeted Python probes. Disallow write/edit/root operations unless explicitly approved, and require interactive confirmation for any network or env-file interaction.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:13`  
**Confidence:** 60%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/check_runtime_preflight.sh:33`  
**Confidence:** 60%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

## Inspection Completeness

| Metric | Value |
|--------|-------|
| Execution | successful |
| Status | partial |
| Coverage | 100.0% |
| Fully inspected | 2 |
| Partially inspected | 0 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| reference_unresolved | `SKILL.md:3-3` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:8-8` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:9-9` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:20-20` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:23-23` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:29-29` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:31-31` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:37-37` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:46-46` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:55-55` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:56-56` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:57-57` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:61-61` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:62-62` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:63-63` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:64-64` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:68-68` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:91-91` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:95-95` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:96-96` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:99-99` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:106-106` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:107-107` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:112-112` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:124-124` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:139-139` | A local path-like reference could not be resolved unambiguously. |

### Analyzer Statuses

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| completed | `` |  |
| no_applicable_files | `` | No files matched this analyzer's applicability contract. |
| no_applicable_files | `` | No files matched this analyzer's applicability contract. |
| no_applicable_files | `` | No files matched this analyzer's applicability contract. |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |

## Metadata

- **Executable Scripts:** Yes

*Generated by SkillSpector v2.11.0*