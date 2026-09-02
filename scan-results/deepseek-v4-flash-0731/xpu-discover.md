# SkillSpector Security Report

**Skill:** xpu-discover  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/xpu-discover`  
**Scanned:** 2026-09-02 02:15:54 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 30/100 |
| Severity | MEDIUM |
| Recommendation | CAUTION |

## Components (1)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 184 | No |

## Issues (2)

### 🔴 HIGH: PE5

**Location:** `SKILL.md:168`  
**Confidence:** 80%  

**Message:** The troubleshooting table instructs users to add `--privileged` when running xpu-smi inside a container to access /dev/dri. While GPU device access can be granted via `--device`, `--privileged` grants the container nearly all host capabilities, including unrestricted access to kernel devices and the ability to perform actions that could lead to container escape. This is an unnecessary privilege escalation risk. The skill author likely intended to simplify container setup for hardware diagnostics, but the guidance is overly permissive and lacks warnings or safer alternatives.

**Remediation:** Replace `--privileged` with precise device mapping (e.g., `--device /dev/dri`) and, if additional ioctl permissions are needed, use targeted Linux capabilities such as `--cap-add=SYS_ADMIN` (or better, `SYS_RAWIO` if supported) rather than the all-encompassing `--privileged` flag. Additionally, advise users to avoid running untrusted workloads in privileged containers.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:169`  
**Confidence:** 80%  

**Message:** The statement 'Container needs `--privileged` for diag ioctls' asserts that privileged mode is mandatory for xpu-smi diagnostic functionality. This is factually inaccurate—many ioctls can be permitted through fine-grained capabilities or device cgroups. More importantly, unconditionally requiring `--privileged` normalizes the most dangerous container mode as the default solution, exposing hosts to severe compromise if the container is breached. The lack of nuance or warning makes it easy for a user to follow this advice blindly, potentially weakening their security posture significantly.

**Remediation:** Clarify that `--privileged` is one possible workaround but not always required. Recommend trying the standard render node interface first (without privileged) and only escalate to specific capability additions if diagnostics fail. Provide explicit examples of safer alternatives, e.g., `docker run --device /dev/dri --group-add video ...` or adding `--cap-add=SYS_ADMIN` as a minimal escalation, and strongly discourage `--privileged` unless absolutely unavoidable.

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
| reference_unresolved | `SKILL.md:17-17` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:73-73` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:74-74` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:84-84` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:109-109` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:111-111` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:112-112` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:122-122` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:142-142` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:156-156` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:160-160` | A local path-like reference could not be resolved unambiguously. |

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