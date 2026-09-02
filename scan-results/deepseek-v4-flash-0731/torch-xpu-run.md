# SkillSpector Security Report

**Skill:** torch-xpu-run  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/torch-xpu-run`  
**Scanned:** 2026-09-02 01:40:08 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 57/100 |
| Severity | HIGH |
| Recommendation | DO NOT INSTALL |

## Components (1)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 318 | No |

## Issues (4)

### 🔴 HIGH: PE5

**Location:** `SKILL.md:89`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:90`  
**Confidence:** 80%  

**Message:** The flag `--ipc=host` shares the host's IPC namespace with the container. This allows the container to access System V shared memory segments and semaphores used by other processes on the host, potentially enabling cross‑container or host‑container interference. An attacker who gains code execution inside the container could read/write sensitive inter‑process data or launch denial‑of‑service attacks against host processes. While this flag is sometimes used for performance, it is not required for GPU access and significantly expands the attack surface.

**Remediation:** Remove `--ipc=host` unless absolutely necessary. Use `--ipc=shareable` or create a dedicated IPC namespace. Alternatively, restrict the container's capabilities and use SELinux/AppArmor profiles. For GPU access alone, `--device /dev/dri` is sufficient; `--ipc=host` is an unnecessary privilege escalation vector.

---

### 🔴 HIGH: YR1

**Location:** `SKILL.md:279`  
**Confidence:** 85%  

**Message:** The skill recommends `pip install git+https://github.com/huggingface/transformers.git` as a troubleshooting step. This command downloads and executes arbitrary Python code from a remote Git repository during installation. Although the target is the official Hugging Face Transformers repository, the pattern is inherently risky: a compromised repository, a typo‑squatted URL, or a MITM attack could result in arbitrary code execution on the host. In an agent context, this instruction could cause the agent to install unverified software without explicit user consent, violating supply‑chain best practices.

**Remediation:** Advise users to first try upgrading via official package indexes (`pip install --upgrade transformers`) or pin a specific commit hash. If building from source is truly needed, recommend cloning the repo to a temporary directory, inspecting it, and then running `pip install .` after manual review. Add a strong caution that executing code from remote repositories carries significant security risks and requires explicit user approval.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:88`  
**Confidence:** 75%  

**Message:** The Docker run example uses a placeholder image name `<torch-xpu-image>` without a specific tag or digest. This invites users (or the agent acting on this skill) to pull an arbitrary image from a registry, which could be malicious or outdated. Even if a concrete image is substituted, failing to pin a tag allows silent updates to a new image version that may behave differently or contain vulnerabilities. In an agent context, if the agent runs this command with a user-specified image, it could execute untrusted code with the privileges granted by the container flags.

**Remediation:** Replace the placeholder with a pinned image reference (e.g., `vllm/vllm-openai-xpu:latest` or better, a specific digest like `@sha256:...`). If the skill must remain generic, add a warning to always specify a trusted image and tag, and instruct the agent to verify the image signature before pulling.

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
| reference_unresolved | `SKILL.md:3-3` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:8-8` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:34-34` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:81-81` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:93-93` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:128-128` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:137-137` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:299-299` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:316-316` | A local path-like reference could not be resolved unambiguously. |

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