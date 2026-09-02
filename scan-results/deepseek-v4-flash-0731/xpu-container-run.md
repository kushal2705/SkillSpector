# SkillSpector Security Report

**Skill:** xpu-container-run  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/xpu-container-run`  
**Scanned:** 2026-09-02 06:34:43 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 48/100 |
| Severity | MEDIUM |
| Recommendation | CAUTION |

## Components (2)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 126 | No |
| `references/server-and-multi-gpu.md` | markdown | 62 | No |

## Issues (36)

### 🔴 HIGH: PE5

**Location:** `SKILL.md:3`  
**Confidence:** 80%  

**Message:** The description mentions '--ipc=host' as part of the required combination. Sharing the host IPC namespace can expose shared memory and semaphores to the container, increasing attack surface. While the skill provides alternatives later, this is included in the default recipe.

**Remediation:** Prefer using '--shm-size=16g' instead of '--ipc=host' unless absolutely required by the workload. Document the risks and require explicit user confirmation for using host IPC.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:17`  
**Confidence:** 70%  

**Message:** The table shows '--device /dev/dri' as the Intel equivalent of '--gpus all'. Passing all DRM nodes may expose multiple GPUs and associated hardware interfaces, broadening the container's device access beyond necessity.

**Remediation:** In the table, highlight that '/dev/dri' exposes all render nodes and recommend the minimal node ('renderD128') for single-GPU use.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:19`  
**Confidence:** 80%  

**Message:** Table entry equating '--ipc=host' with the same option on CUDA side. It presents it as a normal, recommended practice without highlighting security trade-offs.

**Remediation:** Add a security note in the table or surrounding text warning about host IPC exposure and suggesting the private-shm alternative.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:20`  
**Confidence:** 80%  

**Message:** Alternative listed as '--shm-size=16g' which is safer, but the skill still defaults to '--ipc=host' in the quickstart. The existence of a safer option indicates awareness, yet the riskier option remains the primary recommendation.

**Remediation:** Make '--shm-size' the default and reserve '--ipc=host' for specific distributed workloads with explicit justification.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:42`  
**Confidence:** 80%  

**Message:** The quickstart command passes the entire '/dev/dri' directory, giving the container access to all GPU devices and potentially other DRM devices (display, etc.). This is broader than needed for most workloads.

**Remediation:** Use the minimal device node(s) required. Provide examples for both minimal and full access, and advise the user to choose based on their needs.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:44`  
**Confidence:** 80%  

**Message:** The quickstart command includes '--ipc=host' and '--device /dev/dri' without offering the least-privilege alternative inline. This is the actual command the agent may execute. Host IPC and DRM device access together increase risk significantly.

**Remediation:** Change the quickstart to use '--shm-size=16g' instead of '--ipc=host', and restrict device access to the specific render node (e.g., '--device /dev/dri/renderD128') unless multiple GPUs are needed. Add a prominent security warning.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:54`  
**Confidence:** 70%  

**Message:** The explanation correctly notes the least-privilege option ('/dev/dri/renderD128'), but the skill's primary examples still use the broad '/dev/dri' path.

**Remediation:** Make the least-privilege option the default in all commands, and present the broader access as an advanced override.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:56`  
**Confidence:** 80%  

**Message:** Explanation of '--ipc=host' justifies it for vLLM/torch.distributed. The skill acknowledges an alternative but does not clearly indicate that host IPC is a security trade-off.

**Remediation:** Include a security caveat next to the explanation, e.g., 'Only use --ipc=host when you fully trust the container contents.'

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:61`  
**Confidence:** 80%  

**Message:** Lists 'unitrace' and firmware updates as reasons to use '--privileged'. Even though it's conditional, the presence of '--privileged' in a skill could be exploited if the condition is misinterpreted or if a malicious actor influences the decision to enable it.

**Remediation:** Remove '--privileged' from the skill entirely, or strongly discourage it and require explicit user confirmation for each use. Document the extreme risk of container escape.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:70`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:90`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:71`  
**Confidence:** 80%  

**Message:** Suggests adding '--privileged' when permission failures occur. This is a dangerous troubleshooting step that could grant full host control to a container with only a minor issue.

**Remediation:** Advise checking file permissions and using granular capabilities (like CAP_SYS_ADMIN) instead of full '--privileged'. Recommend avoiding '--privileged' for routine tasks.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:74`  
**Confidence:** 80%  

**Message:** The section title mentions '--net=host' for server mode. Host networking removes isolation, allowing the container to bind to host ports and potentially intercept traffic.

**Remediation:** Explain why '--net=host' might be needed (e.g., for InfiniBand) but emphasize that it should be avoided unless strictly necessary. Suggest using port mapping instead.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:79`  
**Confidence:** 80%  

**Message:** Repeats '--net=host' as a topic for multi-GPU setups. The skill does not immediately warn about its security implications.

**Remediation:** Add a security note in this section stating that host networking bypasses network isolation and should only be used when explicitly required.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:93`  
**Confidence:** 80%  

**Message:** The troubleshooting table instructs to add '--privileged' for 'diag' tests that fail. This directly encourages the highest-risk flag in a diagnostic scenario.

**Remediation:** Do not suggest '--privileged' for diagnostics; instead recommend running those diagnostics on the host, or using restricted capabilities.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:98`  
**Confidence:** 80%  

**Message:** Common error handling suggests adding '--privileged' to fix shim permission issues. This is an over-broad fix that exposes the host unnecessarily.

**Remediation:** Provide targeted fixes such as adjusting device cgroup permissions, adding the user to the correct group, or using '--cap-add' instead of '--privileged'.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:123`  
**Confidence:** 80%  

**Message:** Reference to a document about '--net=host' perpetuates the use of this dangerous flag without immediate mitigation.

**Remediation:** Update the referenced document to include strong security warnings and alternatives.

---

### 🔴 HIGH: PE5

**Location:** `references/server-and-multi-gpu.md:7`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/server-and-multi-gpu.md:33`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/server-and-multi-gpu.md:44`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/server-and-multi-gpu.md:9`  
**Confidence:** 80%  

**Message:** `--ipc=host` shares the host's `/dev/shm` and System V IPC namespace. A malicious or compromised container can interact with host-level shared memory, potentially reading sensitive data, causing denial-of-service, or contributing to container escape. This flag appears unconditionally in the primary server-mode command, even though the skill later admits `--shm-size` may be sufficient. The intent is likely performance/compatibility, not malice, but the security risk is real.

**Remediation:** Prefer private IPC with `--shm-size=<size>` (e.g., `--shm-size=32g`) instead of `--ipc=host` unless the workload truly requires host shared memory. If `--ipc=host` is necessary, run only trusted images and add `--cap-drop=ALL` plus a non-root user. Add explicit warnings to the skill.

---

### 🔴 HIGH: PE5

**Location:** `references/server-and-multi-gpu.md:21`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/server-and-multi-gpu.md:23`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/server-and-multi-gpu.md:34`  
**Confidence:** 80%  

**Message:** Multi-GPU loop includes `--ipc=host` in each container. Same risks as finding 4, now multiplied across multiple containers. The skill does not warn about the security implications.

**Remediation:** Use `--shm-size` per container where possible. If host shared memory is required, isolate with dedicated user namespaces and only run verified images.

---

### 🔴 HIGH: PE5

**Location:** `references/server-and-multi-gpu.md:45`  
**Confidence:** 80%  

**Message:** Tensor-parallel / pipeline-parallel example uses `--ipc=host`. This is especially sensitive because `CCL_ZE_IPC_EXCHANGE=pidfd` is also set, enabling IPC-based communication. A malicious container could abuse shared memory to interfere with other host processes.

**Remediation:** Prefer private shared memory with adequate `--shm-size`. If `--ipc=host` is unavoidable, document the threat model and require the image to be trusted.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:106`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/server-and-multi-gpu.md:54`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/server-and-multi-gpu.md:56`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/server-and-multi-gpu.md:61`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:3`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:17`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:18`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:41`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `references/server-and-multi-gpu.md:6`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `references/server-and-multi-gpu.md:32`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `references/server-and-multi-gpu.md:43`  
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
| reference_unresolved | `SKILL.md:29-29` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:30-30` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:47-47` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:55-55` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:56-56` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:105-105` | A local path-like reference could not be resolved unambiguously. |

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