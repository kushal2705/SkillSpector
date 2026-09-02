# SkillSpector Security Report

**Skill:** vllm-xpu-bench  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/vllm-xpu-bench`  
**Scanned:** 2026-09-02 01:44:36 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 68/100 |
| Severity | HIGH |
| Recommendation | DO NOT INSTALL |

## Components (2)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 326 | No |
| `references/sweep-and-compare.md` | markdown | 78 | No |

## Issues (8)

### 🔴 HIGH: PE5

**Location:** `SKILL.md:67`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:107`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:218`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:70`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:221`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: SC2

**Location:** `SKILL.md:93`  
**Confidence:** 90%  

**Message:** External Script Fetching

**Remediation:** Avoid downloading and executing remote scripts. Use trusted packages from PyPI/npm. If remote fetch is required, verify checksums and use HTTPS.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:66`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -d'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:216`  
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
| Fully inspected | 2 |
| Partially inspected | 0 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| reference_unresolved | `SKILL.md:76-76` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:78-78` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:130-130` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:148-148` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:150-150` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:167-167` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:196-196` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:197-197` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:208-208` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:224-224` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:225-225` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:227-227` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:273-273` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:285-285` | A local path-like reference could not be resolved unambiguously. |

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