# SkillSpector Security Report

**Skill:** llamacpp-xpu-run  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/llamacpp-xpu-run`  
**Scanned:** 2026-09-02 00:46:11 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 52/100 |
| Severity | HIGH |
| Recommendation | DO NOT INSTALL |

## Components (4)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 144 | No |
| `references/build-and-env.md` | markdown | 95 | No |
| `references/quantisation-and-bench.md` | markdown | 87 | No |
| `references/troubleshooting.md` | markdown | 69 | No |

## Issues (16)

### 🔴 HIGH: PE5

**Location:** `SKILL.md:27`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/troubleshooting.md:30`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:91`  
**Confidence:** 80%  

**Message:** `--ipc=host` grants the container access to the host's IPC namespace (shared memory, semaphores, message queues). If the container is compromised, an attacker could read/write host IPC objects, potentially leaking sensitive data or interfering with host processes. The flag is not required for llama.cpp functionality and appears to be added without clear justification. This is a genuine security hardening issue.

**Remediation:** Remove `--ipc=host` from the `docker run` command. If shared memory is needed, use `--shm-size` to allocate a dedicated tmpfs instead of exposing the host IPC namespace. Document any necessity for this flag explicitly.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:61`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:89`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/build-and-env.md:69`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/quantisation-and-bench.md:58`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/troubleshooting.md:24`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:76`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run command'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:87`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -d'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: E1

**Location:** `SKILL.md:120`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:60`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `references/build-and-env.md:68`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `references/quantisation-and-bench.md:57`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `references/troubleshooting.md:23`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `references/troubleshooting.md:29`  
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
| Fully inspected | 4 |
| Partially inspected | 0 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| reference_unresolved | `SKILL.md:3-3` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:9-9` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:48-48` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:95-95` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:123-123` | A local path-like reference could not be resolved unambiguously. |

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