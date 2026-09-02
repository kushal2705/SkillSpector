# SkillSpector Security Report

**Skill:** vllm-xpu-profile  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/vllm-xpu-profile`  
**Scanned:** 2026-09-02 01:48:40 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 51/100 |
| Severity | HIGH |
| Recommendation | DO NOT INSTALL |

## Components (1)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 184 | No |

## Issues (7)

### 🔴 HIGH: PE5

**Location:** `SKILL.md:30`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:115`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:33`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:118`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:29`  
**Confidence:** 75%  

**Message:** The Docker image is referenced with the mutable tag `latest`. This is a supply-chain risk: the image can be changed or replaced upstream without notice, potentially introducing a different (possibly vulnerable) build when the user runs the skill. Since the skill also grants GPU device access and host IPC, an unexpected image variant could have serious consequences.

**Remediation:** Pin the image to a specific release tag (e.g., `vllm/vllm-openai-xpu:0.6.1.post1`) or use a SHA-256 digest (e.g., `vllm/vllm-openai-xpu@sha256:<digest>`). Verify the image signature or checksum before running.

---

### 🟡 MEDIUM: E1

**Location:** `SKILL.md:54`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:113`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

## Inspection Completeness

| Metric | Value |
|--------|-------|
| Execution | successful |
| Status | partial |
| Coverage | 100.0% |
| Fully inspected | 1 |
| Partially inspected | 0 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| reference_unresolved | `SKILL.md:8-8` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:23-23` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:24-24` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:39-39` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:40-40` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:42-42` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:43-43` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:55-55` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:56-56` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:65-65` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:66-66` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:75-75` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:76-76` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:93-93` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:123-123` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:124-124` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:125-125` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:127-127` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:138-138` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:178-178` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:179-179` | A local path-like reference could not be resolved unambiguously. |

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