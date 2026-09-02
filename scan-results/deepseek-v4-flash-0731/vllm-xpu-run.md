# SkillSpector Security Report

**Skill:** vllm-xpu-run  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/vllm-xpu-run`  
**Scanned:** 2026-09-02 06:21:39 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 100/100 |
| Severity | CRITICAL |
| Recommendation | DO NOT INSTALL |

## Components (5)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 230 | No |
| `references/multi-gpu-and-tuning.md` | markdown | 126 | No |
| `references/quantization.md` | markdown | 45 | No |
| `references/remote-deploy.md` | markdown | 99 | No |
| `scripts/emit_launch.sh` | shell | 258 | Yes |

## Issues (21)

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 95%  

**Message:** Description-behavior mismatch: declared purpose is 'Serve a Hugging Face safetensors model on Intel GPU with vLLM-XPU's OpenAI-compatible API, or check whether a model/architecture is documented on XPU. Covers live support lookup, image choice, container launch, serve-flag requirements, model-impl fallback, and attention/quant compatibility.' but code also performs: Live support lookup, Checking whether a model/architecture is documented on XPU, Directly serving /v1/chat/completions or /v1/completions.

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `A bash script that validates arguments, optionally parses a model-config-recommend file, and prints one or more `docker run` commands to launch vLLM-XPU with specified model, quantization, tensor/dp parallelism, ports, and environment variables. It does not interact with any external service, check model documentation, or serve any HTTP endpoints itself.`
- **code_end_line:** `258`
- **code_path:** `scripts/emit_launch.sh`
- **code_start_line:** `1`

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:52`  
**Confidence:** 80%  

**Message:** The cheat-sheet recommends `--ipc=host`. This removes the container's IPC namespace isolation and allows container processes to share memory/semaphore objects with the host. While often required for oneCCL initialization on XPU, it increases the blast radius if the container is compromised. The skill does not mention this security trade-off.

**Remediation:** Document the need for `--ipc=host`, recommend deploying only on trusted hosts, and suggest evaluating `--ipc=shareable` or other isolation options where compatible.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:72`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:75`  
**Confidence:** 80%  

**Message:** The concrete `docker run` command includes `--ipc=host` and `--device /dev/dri`. Both reduce isolation. Combined with a writable Hugging Face cache mount, a compromised container could affect host IPC and GPU state. This is a real security-hardening issue, though the flags are functionally required for the intended workload.

**Remediation:** Add a prominent warning about the security implications, keep container images patched, and restrict the host environment to trusted users.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:110`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:226`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:184`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/multi-gpu-and-tuning.md:32`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `references/remote-deploy.md:28`  
**Confidence:** 80%  

**Message:** --device /dev/dri exposes the entire GPU device node to the container. While required for hardware acceleration, it grants direct access to the DRM subsystem and could enable kernel exploits if the container is compromised. The scope of device exposure should be minimized.

**Remediation:** Use --device /dev/dri/renderD128 (and any other required device nodes) instead of the whole directory. Additionally, ensure the container runs under a non-root user and apply AppArmor/SELinux profiles to confine the container.

---

### 🔴 HIGH: PE5

**Location:** `references/remote-deploy.md:31`  
**Confidence:** 80%  

**Message:** --ipc=host removes IPC namespace isolation, allowing the container to interact with host processes' shared memory and semaphores. If a model contains malicious code (or is compromised at runtime), an attacker could leverage this to attack the host. Combined with GPU device passthrough, the attack surface expands significantly.

**Remediation:** Replace --ipc=host with --shm-size=<size> (e.g., --shm-size=16g) to provide adequate shared memory for vLLM without full host IPC. Also add --cap-drop=ALL and --security-opt=no-new-privileges to further restrict capabilities.

---

### 🔴 HIGH: PE5

**Location:** `scripts/emit_launch.sh:239`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `scripts/emit_launch.sh:242`  
**Confidence:** 80%  

**Message:** `--ipc=host` removes the IPC namespace isolation between the container and the host. This lets the container interact with host-level System V IPC objects, POSIX shared memory, and semaphores, and potentially interfere with other processes or containers sharing that namespace. While it does not grant full container escape by itself, it significantly broadens the attack surface if the vLLM server is compromised. A malicious model or crafted request leading to RCE inside the container could then access sensitive inter-process data on the host. This flag appears to be included out of convenience or habit (common for some MPI-style workloads), not because vLLM requires it. The script already sets `VLLM_WORKER_MULTIPROC_METHOD=spawn`, so host IPC is not needed for multiprocessing.

**Remediation:** Remove `--ipc=host` from the generated `docker run` command. If shared memory is needed for tensor parallelism or DataLoader, use `--shm-size` (e.g., `--shm-size=16g`) or a named volume for `/dev/shm` instead. Only keep `--ipc=host` if absolutely required for a specific multi-container communication pattern, and document that decision with a security review.

---

### 🟡 MEDIUM: SQP-2

**Location:** `SKILL.md:82–83`  
**Confidence:** 95%  

**Message:** The Docker command uses `-p 8000:8000`, which publishes the vLLM OpenAI-compatible server on all host interfaces (0.0.0.0). vLLM's API is unauthenticated unless `--api-key` is set. On a machine with a public IP, anyone could submit prompts, exhaust GPU resources, or steal request/response data. The skill then tests via `curl http://localhost:8000`, implying local use, but the binding itself permits remote access. No warning is provided.

**Remediation:** Bind to localhost with `-p 127.0.0.1:8000:8000`, or enable authentication with `--api-key`, and document firewall restrictions.

---

### 🟡 MEDIUM: E1

**Location:** `SKILL.md:95`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: RP1

**Location:** `references/multi-gpu-and-tuning.md:31`  
**Confidence:** 80%  

**Message:** The Docker image `vllm/vllm-openai-xpu:latest` uses a mutable `latest` tag. This means the container's base image can change without explicit consent, potentially pulling a compromised or incompatible version. An attacker who compromises the image registry or the repository maintainer could replace the `latest` tag with a malicious image, leading to arbitrary code execution when the container runs.

**Remediation:** Pin the image to a specific version tag (e.g., `vllm/vllm-openai-xpu:v0.7.0`) or, better, to a digest (e.g., `vllm/vllm-openai-xpu@sha256:...`) to ensure reproducibility and prevent supply-chain attacks.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:71`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -d'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `references/remote-deploy.md:27`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -d'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `scripts/emit_launch.sh:238`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -d'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: E1

**Location:** `references/remote-deploy.md:75`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟢 LOW: SQP-2

**Location:** `references/multi-gpu-and-tuning.md:31–38`  
**Confidence:** 70%  

**Message:** The skill description lacks any warning about security-sensitive operations performed by the provided commands: passing the HF_TOKEN environment variable into a container (line L036), mounting the user's Hugging Face cache directory (line L037), and exposing port 8000 (line L038). These actions could expose credentials, leak local data, or open network access without user awareness.

**Remediation:** Add a warning near the top of the section or immediately before the Docker command, e.g., 'These commands forward your HF token and mount your local Hugging Face cache into the container; ensure you trust the container image and network environment.'

---

### 🟢 LOW: SQP-2

**Location:** `references/remote-deploy.md:34–52`  
**Confidence:** 70%  

**Message:** The reference documents mapping host port 8000 and optionally passing an HF_TOKEN environment variable without any warning. Exposing a publicly reachable inference endpoint can lead to abuse, denial-of-service, and token leakage if the host is network-exposed.

**Remediation:** Add explicit security notes: restrict ingress firewall rules, avoid binding to 0.0.0.0 if possible, use TLS in front, never commit HF_TOKEN to shell history or logs, and consider short-lived tokens.

---

## Inspection Completeness

| Metric | Value |
|--------|-------|
| Execution | successful |
| Status | partial |
| Coverage | 80.0% |
| Fully inspected | 4 |
| Partially inspected | 1 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| reference_unresolved | `SKILL.md:3-3` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:8-8` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:32-32` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:51-51` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:81-81` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:83-83` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:84-84` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:96-96` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:97-97` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:117-117` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:120-120` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:147-147` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:211-211` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:220-220` | A local path-like reference could not be resolved unambiguously. |
| static_parse_limit | `references/remote-deploy.md` | A security-relevant expression exceeded a bounded static parser's span limit. |

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
| degraded | `` |  |
| completed | `` |  |

### Limitations

- Analyzer static_patterns_tool_misuse status: degraded.

## Metadata

- **Executable Scripts:** Yes

*Generated by SkillSpector v2.11.0*