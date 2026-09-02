# SkillSpector Security Report

**Skill:** sglang-xpu-run  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/sglang-xpu-run`  
**Scanned:** 2026-09-02 01:31:57 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 100/100 |
| Severity | CRITICAL |
| Recommendation | DO NOT INSTALL |

## Components (2)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 332 | No |
| `references/spec-decode-and-multimodal.md` | markdown | 37 | No |

## Issues (24)

### 🔴 HIGH: PE5

**Location:** `SKILL.md:43`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:65`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:86`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:92`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:122`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:66`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:87`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:123`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:94`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:99`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: SC2

**Location:** `SKILL.md:151`  
**Confidence:** 90%  

**Message:** External Script Fetching

**Remediation:** Avoid downloading and executing remote scripts. Use trusted packages from PyPI/npm. If remote fetch is required, verify checksums and use HTTPS.

---

### 🔴 HIGH: SC2

**Location:** `SKILL.md:161`  
**Confidence:** 90%  

**Message:** External Script Fetching

**Remediation:** Avoid downloading and executing remote scripts. Use trusted packages from PyPI/npm. If remote fetch is required, verify checksums and use HTTPS.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:213`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:214`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:53`  
**Confidence:** 80%  

**Message:** The skill instructs users to pull `intel/sglang-dev:latest` without a pinned tag or digest. This introduces supply-chain risk: a future update of the image could break compatibility, introduce regressions, or contain malicious modifications. Because the image is used with `--privileged`, any compromise of the image could lead to full host takeover.

**Remediation:** Pin the image to a specific tag (e.g., `intel/sglang-dev:2025.01.01`) or, ideally, a SHA-256 digest (e.g., `intel/sglang-dev@sha256:...`). Verify the digest after pulling and document the exact version tested.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:64`  
**Confidence:** 75%  

**Message:** This `docker run` command does not specify an image tag, defaulting to `latest`. Same supply-chain risk as the previous finding. Also, the command uses `--privileged` and `--network host`, compounding the risk if the image is compromised.

**Remediation:** Use a fully qualified image reference with digest, and consider reducing privileges where possible.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:92`  
**Confidence:** 80%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:293`  
**Confidence:** 80%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:121`  
**Confidence:** 75%  

**Message:** Same issue: `docker run -d` without a pinned image tag. The command also runs with `--privileged` and exposes the model serving endpoint, so a tampered image could serve malicious responses or execute arbitrary code.

**Remediation:** Pin the image to a specific version and digest.

---

### 🟡 MEDIUM: E1

**Location:** `SKILL.md:161`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:212`  
**Confidence:** 75%  

**Message:** Multi-GPU launch command also omits a pinned image tag. Same risks as above.

**Remediation:** Use a pinned image reference.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:288`  
**Confidence:** 75%  

**Message:** Diagnostic `docker run --rm` again uses `latest` implicitly. This may execute an untrusted image during troubleshooting, increasing attack surface.

**Remediation:** Always reference a specific tag or digest.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:330`  
**Confidence:** 75%  

**Message:** Reference section repeats the un-pinned image instruction, reinforcing the bad practice.

**Remediation:** Update documentation to show a pinned image example.

---

### 🟢 LOW: TM1

**Location:** `SKILL.md:288`  
**Confidence:** 15%  

**Message:** Tool Parameter Abuse

**Remediation:** Validate all tool parameters against an allowlist. Reject dangerous parameter values (shell=True, --force, -rf /) and use safe defaults.

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
| reference_unresolved | `SKILL.md:9-9` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:28-28` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:42-42` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:53-53` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:56-56` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:72-72` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:74-74` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:112-112` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:125-125` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:130-130` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:132-132` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:162-162` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:172-172` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:216-216` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:221-221` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:223-223` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:241-241` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:250-250` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:253-253` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:281-281` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:286-286` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:288-288` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:330-330` | A local path-like reference could not be resolved unambiguously. |

### Analyzer Statuses

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| completed | `` |  |
| no_applicable_files | `` | No files matched this analyzer's applicability contract. |
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

## Metadata

- **Executable Scripts:** No

*Generated by SkillSpector v2.11.0*