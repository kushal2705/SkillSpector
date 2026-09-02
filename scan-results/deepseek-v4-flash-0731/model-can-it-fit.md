# SkillSpector Security Report

**Skill:** model-can-it-fit  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/model-can-it-fit`  
**Scanned:** 2026-09-02 01:10:54 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 17/100 |
| Severity | LOW |
| Recommendation | CAUTION |

## Components (4)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 212 | No |
| `references/coverage-and-formulas.md` | markdown | 111 | No |
| `references/runtime-caveats.md` | markdown | 97 | No |
| `scripts/fit.py` | python | 908 | Yes |

## Issues (2)

### 🟡 MEDIUM: LP3

**Location:** `SKILL.md:1`  
**Confidence:** 85%  

**Message:** The skill definition lacks explicit permission or allowed-tools declarations, while the accompanying Python script (`fit.py`) clearly requires access to environment variables (HF_TOKEN, HUGGING_FACE_HUB_TOKEN) and network connectivity (to fetch model configs from Hugging Face Hub). Without declared scopes, an agent runtime may either block the skill outright (functional failure) or grant it broad, unvetted access to the host's environment and network. If granted excessive privileges, a compromised or malicious model repository could exfiltrate the user's Hugging Face token, trigger arbitrary network requests, or read other environment variables. Even if unintentional, this omission violates least-privilege best practices and undermines user consent and auditability.

**Remediation:** Add a `permissions` or `allowed-tools` section to the skill metadata explicitly enumerating the minimal required capabilities, e.g.:
- `env.read`: to access HF_TOKEN/HUGGING_FACE_HUB_TOKEN
- `network.connect`: restricted to huggingface.co (or use a proxy)
- Optionally `subprocess.exec` for xpu-smi, if that capability isn't already implied.
Additionally, implement secret handling safeguards (e.g., never log tokens, prefer short-lived credentials) and review the script for any unsafe deserialization or command injection vectors.

---

### 🟡 MEDIUM: SDI-1

**Location:** `references/runtime-caveats.md:78–79`  
**Confidence:** 85%  

**Message:** Manifest states 'Not for diffusion', but the documentation instructs users to point the script at diffusion component configs (UNet/transformer) to obtain floor estimates, effectively bypassing the stated limitation and extending the skill's scope beyond its declared purpose.

**Remediation:** Remove the workaround suggestion or update the manifest to clarify that component-level estimates for diffusion are acceptable if the user understands they are not full diffusion pipeline estimates. Alternatively, explicitly state the limitation and recommend using torch-xpu-bench for diffusion models.

---

## Inspection Completeness

| Metric | Value |
|--------|-------|
| Execution | successful |
| Status | partial |
| Coverage | 100.0% |
| Fully inspected | 4 |
| Partially inspected | 0 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| reference_unresolved | `SKILL.md:3-3` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:10-10` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:19-19` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:23-23` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:90-90` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:91-91` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:102-102` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:110-110` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:119-119` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:162-162` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:163-163` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:201-201` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:203-203` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:211-211` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:212-212` | A local path-like reference could not be resolved unambiguously. |

### Analyzer Statuses

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
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