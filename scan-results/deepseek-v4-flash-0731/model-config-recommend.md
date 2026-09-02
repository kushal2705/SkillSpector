# SkillSpector Security Report

**Skill:** unknown  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/model-config-recommend`  
**Scanned:** 2026-09-02 06:06:40 UTC  

> ⚠️ **Degraded scan:** LLM analysis was requested but 1 of 4 LLM call(s) failed - results reflect STATIC analysis only for the affected batch(es).

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 100/100 |
| Severity | CRITICAL |
| Recommendation | DO NOT INSTALL |

## Components (8)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 274 | No |
| `data/hardware.json` | json | 108 | No |
| `scripts/calibrate.py` | python | 254 | Yes |
| `scripts/common.py` | python | 196 | Yes |
| `scripts/llm_roofline.py` | python | 156 | Yes |
| `scripts/recommend.py` | python | 795 | Yes |
| `scripts/roofline.py` | python | 124 | Yes |
| `scripts/verify.py` | python | 323 | Yes |

## Issues (32)

### 🔴 HIGH: AE1

**Location:** `SKILL.md:32`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:47`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:53`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:82`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:102`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:122`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:126`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:208`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:212`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:49`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:65`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:237`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: PE5

**Location:** `scripts/calibrate.py:73`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `scripts/recommend.py:525`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `scripts/recommend.py:528`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `scripts/verify.py:127`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:37`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run ...'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:102`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:228`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/calibrate.py:89`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/calibrate.py:133–134`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: SSRF2

**Location:** `scripts/calibrate.py:146`  
**Confidence:** 70%  

**Message:** Internal Network Request

**Remediation:** Avoid requests to loopback/link-local/private hosts from skill code. If internal access is intended, document it and validate the target against an allowlist.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/common.py:183–186`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/common.py:192–195`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/recommend.py:88–89`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: RP1

**Location:** `scripts/recommend.py:524`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/verify.py:155`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: SSRF2

**Location:** `scripts/verify.py:194`  
**Confidence:** 70%  

**Message:** Internal Network Request

**Remediation:** Avoid requests to loopback/link-local/private hosts from skill code. If internal access is intended, document it and validate the target against an allowlist.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/verify.py:318–319`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟢 LOW: SDI-4

**Location:** `scripts/calibrate.py:5–9`  
**Confidence:** 90%  

**Message:** Docstring claims the script 'call[s] recommend.py with the calibrated factors' (L009), but the implementation never invokes recommend.py. Instead, it writes the calibration cache and prints a suggestion to run recommend.py manually (L249). This is an intent-code divergence.

**Remediation:** Update the docstring to reflect that the script caches results and instructs the user to run recommend.py separately, or modify the script to actually invoke recommend.py after calibration.

---

### 🟢 LOW: SQP-2

**Location:** `scripts/calibrate.py:87–89`  
**Confidence:** 80%  

**Message:** The script reads the HF_TOKEN environment variable and passes it into the Docker container (lines L087–L088) without any user-facing disclosure (no print, log, docstring mention, or comment explaining this action). Accessing and forwarding credentials is a safety-critical operation that should be surfaced to the user.

**Remediation:** Add a print statement when HF_TOKEN is used, e.g., 'Using HF_TOKEN for model download.', or document it in the skill description.

---

### 🟢 LOW: SDI-4

**Location:** `scripts/common.py:29–31`  
**Confidence:** 90%  

**Message:** Comment contradicts code behavior: the suppression justification at L029-L030 states 'callers build url from the https://huggingface.co literal; scheme and host are not reachable from any parameter,' but the `http_get_json` function accepts an arbitrary `url` argument. Any caller can pass any URL, making the claim false. This misleading comment obscures the fact that the function performs network requests to user-supplied destinations.

**Remediation:** Either enforce the intended URL restriction inside `http_get_json` or correct the comment to accurately describe the behavior.

---

## Inspection Completeness

| Metric | Value |
|--------|-------|
| Execution | successful |
| Status | partial |
| Coverage | 87.5% |
| Fully inspected | 7 |
| Partially inspected | 1 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| manifest_parse_error | `SKILL.md` | Manifest frontmatter is malformed or uses an unsupported value shape. |
| reference_unresolved | `SKILL.md:3-3` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:15-15` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:48-48` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:54-54` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:61-61` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:62-62` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:65-65` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:66-66` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:85-85` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:95-95` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:125-125` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:140-140` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:142-142` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:144-144` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:146-146` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:147-147` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:166-166` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:191-191` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:193-193` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:194-194` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:195-195` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:196-196` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:197-197` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:215-215` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:224-224` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:230-230` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:235-235` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:252-252` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:258-258` | A local path-like reference could not be resolved unambiguously. |
| runtime_limit | `scripts/common.py` | Inspection reached its configured runtime limit. |
| runtime_limit | `scripts/recommend.py` | Inspection reached its configured runtime limit. |
| runtime_limit | `scripts/verify.py` | Inspection reached its configured runtime limit. |

### Analyzer Statuses

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| completed | `` |  |
| completed | `` |  |
| completed | `` |  |
| no_applicable_files | `` | No files matched this analyzer's applicability contract. |
| manifest_absent | `` | No compatible manifest was present for this analyzer. |
| completed | `` |  |
| manifest_absent | `` | No compatible manifest was present for this analyzer. |
| degraded | `` |  |
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

### Limitations

- Analyzer meta_analyzer status: degraded.

## Metadata

- **Executable Scripts:** Yes

*Generated by SkillSpector v2.11.0*