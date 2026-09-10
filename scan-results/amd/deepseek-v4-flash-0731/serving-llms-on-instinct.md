# SkillSpector Security Report

**Skill:** serving-llms-on-instinct  
**Source:** `/Users/kmittal/Code/GTM/amd-skills/skills/serving-llms-on-instinct`  
**Scanned:** 2026-09-08 21:56:02 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 100/100 |
| Severity | CRITICAL |
| Recommendation | DO NOT INSTALL |

## Components (13)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 359 | No |
| `data/blacklist.json` | json | 59 | No |
| `data/gpu_overrides.json` | json | 154 | No |
| `data/recipes_cache.json` | json | 11064 | No |
| `evals/evals.json` | json | 54 | No |
| `evals/hooks.py` | python | 88 | Yes |
| `evals/machine.yml` | yaml | 1 | No |
| `reference.md` | markdown | 107 | No |
| `scripts/detect.py` | python | 130 | Yes |
| `scripts/estimate_vram.py` | python | 254 | Yes |
| `scripts/sync_recipes.py` | python | 200 | Yes |
| `scripts/validate.py` | python | 207 | Yes |
| `skill-card.md` | markdown | 13 | No |

## Issues (154)

### 🔴 CRITICAL: P5

**Location:** `data/recipes_cache.json:3524`  
**Confidence:** 95%  

**Message:** Harmful Content Injection

**Remediation:** Remove all content that could lead to harmful outcomes. Add safety guardrails and human oversight for any high-risk operations.

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 100%  

**Message:** Description-behavior mismatch: declared purpose is 'The description claims the skill serves AI models on AMD Instinct GPUs using vLLM, handling GPU detection, environment validation, vLLM configuration, launch, and health verification.' but code also performs: Model serving on AMD GPUs, GPU detection, Environment validation, vLLM configuration, Launch and health verification.

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `The code is an eval hook that cleans up stale Docker containers running a specific small model (Qwen/Qwen3-0.6B) to ensure a clean environment for evaluation runs. It does not serve, configure, or validate any models or GPUs.`
- **code_end_line:** `88`
- **code_path:** `evals/hooks.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 100%  

**Message:** Description-behavior mismatch: declared purpose is 'Serve AI models on AMD Instinct GPUs using vLLM, including GPU detection, environment validation, vLLM configuration, launch, and health verification.' but code also performs: The code does not configure or launch vLLM servers., The code does not perform environment validation or health verification of a running service., The code only performs GPU detection and reporting, not the full model-serving workflow described..

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `A standalone Python script that detects AMD GPUs via amd-smi, outputs GPU details (count, gfx version, VRAM, ROCm version) as JSON, and supports local or remote (SSH) execution.`
- **code_end_line:** `130`
- **code_path:** `scripts/detect.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 100%  

**Message:** Description-behavior mismatch: declared purpose is 'Skill that serves AI models on AMD Instinct GPUs using vLLM, including GPU detection, environment validation, vLLM configuration, launch, and health verification.' but code also performs: GPU detection on AMD hardware, vLLM configuration and launch, Environment validation, Health verification of running models, Any interaction with AMD Instinct GPUs or ROCm.

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `A standalone Python script that estimates VRAM requirements for HuggingFace models by fetching safetensors metadata and model config, then computes weight memory, KV cache size, and optional context-length fit. No GPU interaction, no vLLM code, no serving capability, and no AMD-specific logic.`
- **code_end_line:** `254`
- **code_path:** `scripts/estimate_vram.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 98%  

**Message:** Description-behavior mismatch: declared purpose is 'Serves AI models on AMD Instinct GPUs using vLLM, including GPU detection, environment validation, vLLM configuration, launch, and health verification.' but code also performs: Primary purpose is completely different: cache synchronization vs. model serving, No GPU detection, environment validation, vLLM configuration, launch, or health verification logic, The script exits with status 0 regardless of outcome, whereas a serving workflow would have state and interactive behavior, The script accesses GitHub and Docker Hub, but does not interact with GPU hardware or vLLM at all.

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `The script clones the vllm-project/recipes GitHub repository, parses model YAML files, fetches the latest stable Docker Hub tag for vllm/vllm-openai-rocm, and writes a local JSON cache of recipes and tag info. It does not perform any model serving, GPU detection, or vLLM launch/verification.`
- **code_end_line:** `200`
- **code_path:** `scripts/sync_recipes.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 95%  

**Message:** Description-behavior mismatch: declared purpose is 'Serves AI models on AMD Instinct GPUs using vLLM, with full flow including GPU detection, environment validation, vLLM configuration, launch, and health verification.' but code also performs: The declared description claims to handle vLLM configuration, launch, and health verification, but the code only performs environment validation., The declared description implies a full service management skill, but the actual code is only a pre-launch validation utility., No logic exists in the code for starting or managing a vLLM server, nor for detecting specific AMD Instinct GPU models (MI300X, MI325X, etc.) beyond checking generic device nodes..

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `The provided code is a standalone validation script (validate.py) that checks the environment for prerequisites such as /dev/kfd, /dev/dri, Docker availability, NUMA balancing, hipBLASLt presence, HF_TOKEN, and vLLM Docker image. It reports issues and exits with a JSON status. It does not configure, launch, or verify a running vLLM instance.`
- **code_end_line:** `207`
- **code_path:** `scripts/validate.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:39`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:93`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:106`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:119`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:132`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: PE5

**Location:** `data/gpu_overrides.json:5`  
**Confidence:** 90%  

**Message:** Adding the SYS_PTRACE capability grants the container the ability to trace and inspect arbitrary processes within its PID namespace. This is not required for serving vLLM models. If the container is compromised, an attacker could use ptrace to extract secrets from other processes in the container, escalate privileges, or potentially exploit kernel vulnerabilities to affect the host. The flag is likely copied from common AMD GPU examples, but it is an unnecessary privilege that increases attack surface.

**Remediation:** Remove --cap-add=SYS_PTRACE unless a specific debugging tool requires it. For vLLM serving, drop all capabilities and only add the minimum required for GPU access (e.g., --cap-add=SYS_ADMIN if needed for ROCm, but often not necessary). Use --cap-drop=ALL and then add back only needed caps.

---

### 🔴 HIGH: PE5

**Location:** `data/gpu_overrides.json:6`  
**Confidence:** 95%  

**Message:** Setting --security-opt seccomp=unconfined disables the container's seccomp filter, allowing the container to invoke any system call. This removes a key isolation mechanism and significantly expands the kernel attack surface. A compromised container could exploit unknown kernel vulnerabilities to break out of the container. This flag is not required for vLLM; it is often used for compatibility with GPU drivers but should be avoided if possible. If specific syscalls are needed, a custom seccomp profile should be used instead.

**Remediation:** Remove --security-opt seccomp=unconfined. Use the default seccomp profile, or a custom profile that allows only the necessary syscalls for ROCm and vLLM. Test the container to ensure it still functions.

---

### 🔴 HIGH: PE5

**Location:** `data/gpu_overrides.json:7`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/gpu_overrides.json:8`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `scripts/validate.py:84`  
**Confidence:** 70%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/gpu_overrides.json:9`  
**Confidence:** 90%  

**Message:** Using --ipc=host shares the host's IPC namespace with the container. This allows the container to access host shared memory segments, message queues, and semaphores. An attacker inside the container could read/write to host processes' shared memory, potentially stealing sensitive data or injecting malicious content. vLLM does not require host IPC; it uses its own shared memory for tensor parallelism within the container. This flag is unnecessary and significantly weakens isolation.

**Remediation:** Remove --ipc=host. Use the default IPC namespace for the container. If shared memory needs to be increased, use --shm-size instead (e.g., --shm-size=2g).

---

### 🔴 HIGH: YR1

**Location:** `data/recipes_cache.json:49`  
**Confidence:** 85%  

**Message:** YARA rule 'agent_skill_remote_bootstrap_execution': Remote script or code download followed by execution/bootstrap installation [agent_skills]

**Remediation:** Remove the malware payload or compromised file entirely. Investigate how it entered the skill and audit all other artifacts for additional indicators of compromise.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:247`  
**Confidence:** 85%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:386`  
**Confidence:** 85%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:528`  
**Confidence:** 85%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:670`  
**Confidence:** 85%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:5560`  
**Confidence:** 85%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:5642`  
**Confidence:** 85%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:5806`  
**Confidence:** 85%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:739`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:848`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:995`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:1121`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:1252`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:8928`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:9060`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:9155`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:9867`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:10589`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:10720`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:3018`  
**Confidence:** 85%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:6863`  
**Confidence:** 85%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:5249`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: SC2

**Location:** `data/recipes_cache.json:6135`  
**Confidence:** 90%  

**Message:** External Script Fetching

**Remediation:** Avoid downloading and executing remote scripts. Use trusted packages from PyPI/npm. If remote fetch is required, verify checksums and use HTTPS.

---

### 🔴 HIGH: P6

**Location:** `data/recipes_cache.json:6863`  
**Confidence:** 85%  

**Message:** Direct Prompt Extraction

**Remediation:** Remove any instructions that reveal, print, or output system prompts or internal rules. System instructions should never be exposed to end users.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:9583`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/recipes_cache.json:9855`  
**Confidence:** 85%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `reference.md:54`  
**Confidence:** 85%  

**Message:** `--cap-add=SYS_PTRACE` grants ptrace capabilities inside the container. This increases the impact of a compromised container: an attacker could inspect process memory, inject code, or exploit kernel/container escape vulnerabilities. The doc claims it is required for ROCm JIT, but it should be paired with explicit risk awareness and capability dropping.

**Remediation:** Use `--cap-drop=ALL --cap-add=SYS_PTRACE` to avoid retaining unrelated capabilities. Document why it is needed and include a warning that the container is not fully isolated.

---

### 🔴 HIGH: PE5

**Location:** `reference.md:55`  
**Confidence:** 85%  

**Message:** `--security-opt seccomp=unconfined` disables the seccomp syscall filter for the container, allowing all syscalls. This is a major reduction in container isolation. Even if ROCm requires uncommon syscalls, disabling seccomp entirely is risky and unnecessary in many environments.

**Remediation:** Use a custom seccomp profile that permits only the syscalls required by ROCm/vLLM instead of disabling seccomp. Add a warning that this flag weakens container security.

---

### 🔴 HIGH: PE5

**Location:** `reference.md:56`  
**Confidence:** 70%  

**Message:** Passing `/dev/kfd` to the container exposes the AMD GPU kernel driver. This is required for GPU access, but it means a compromised container can interact with GPU hardware and driver interfaces. Driver vulnerabilities could potentially lead to host kernel compromise.

**Remediation:** Keep the device access because it is core functionality, but ensure the container image is trusted, run with reduced capabilities, and use seccomp if possible. Document the risk.

---

### 🔴 HIGH: PE5

**Location:** `reference.md:57`  
**Confidence:** 70%  

**Message:** Passing `/dev/dri` gives the container access to DRM render nodes. This is needed for AMD GPU command submission, but it is another device exposure that increases the attack surface. A malicious container could attempt to exploit GPU driver bugs.

**Remediation:** Same as `/dev/kfd`: keep only if required, use trusted images, minimize other privileges, and include a security note.

---

### 🔴 HIGH: PE5

**Location:** `reference.md:58`  
**Confidence:** 80%  

**Message:** `--ipc=host` shares the host IPC namespace with the container, allowing container processes to access host shared memory segments, semaphores, and message queues. This can expose sensitive data or allow interference with host processes. It is often unnecessary for GPU workloads.

**Remediation:** Remove `--ipc=host` unless proven necessary. If large shared-memory space is needed for vLLM, use `--shm-size` instead. If host IPC is truly required, add a security warning and restrict the container to trusted images.

---

### 🔴 HIGH: TM2

**Location:** `reference.md:92`  
**Confidence:** 75%  

**Message:** The pattern `echo 0 | sudo tee /proc/sys/kernel/numa_balancing` is a standard way to write to a privileged file, but it is also a generic privileged-write primitive. If an attacker can influence the skill's content or parameters, this pattern could be repurposed to overwrite arbitrary root-owned files.

**Remediation:** Replace with `sudo sysctl -w kernel.numa_balancing=0` to make the intent explicit and reduce arbitrary write risk. Even then, require user consent and validate the command before execution.

---

### 🔴 HIGH: LP1

**Location:** `scripts/detect.py:1`  
**Confidence:** 75%  

**Message:** The script reads environment variables `ROCM_SSH_HOST`, `ROCM_SSH_USER`, and `ROCM_SSH_PORT` to control remote execution. In a sandboxed agent environment, this constitutes an undeclared capability. An attacker who can control the environment could redirect the script to an unintended host or cause it to execute commands remotely. Even though the command is fixed, the ability to read environment variables is a permission boundary that should be explicitly declared in the skill's metadata.

**Remediation:** Declare `read-environment` and `ssh` permissions in the skill manifest. Restrict environment variable access to only those needed, and prefer explicit arguments over environment variables.

---

### 🔴 HIGH: TM1

**Location:** `scripts/detect.py:32`  
**Confidence:** 90%  

**Message:** Tool Parameter Abuse

**Remediation:** Validate all tool parameters against an allowlist. Reject dangerous parameter values (shell=True, --force, -rf /) and use safe defaults.

---

### 🔴 HIGH: TM1

**Location:** `scripts/validate.py:33`  
**Confidence:** 90%  

**Message:** Tool Parameter Abuse

**Remediation:** Validate all tool parameters against an allowlist. Reject dangerous parameter values (shell=True, --force, -rf /) and use safe defaults.

---

### 🔴 HIGH: LP1

**Location:** `scripts/estimate_vram.py:1`  
**Confidence:** 75%  

**Message:** Code capability 'network' detected in scripts/estimate_vram.py but not covered by declared permissions.

**Remediation:** Add a tool that covers the 'network' capability to the 'allowed-tools' frontmatter field in SKILL.md, or remove the code that requires it.

---

### 🔴 HIGH: LP1

**Location:** `scripts/sync_recipes.py:1`  
**Confidence:** 75%  

**Message:** Code capability 'file_write' detected in scripts/sync_recipes.py but not covered by declared permissions.

**Remediation:** Add a tool that covers the 'file_write' capability to the 'allowed-tools' frontmatter field in SKILL.md, or remove the code that requires it.

---

### 🔴 HIGH: TM2

**Location:** `scripts/validate.py:122`  
**Confidence:** 75%  

**Message:** Chaining Abuse

**Remediation:** Limit tool chaining depth and validate the output of each tool before passing it to the next. Require explicit user approval for multi-step chains.

---

### 🔴 HIGH: TM2

**Location:** `scripts/validate.py:130`  
**Confidence:** 75%  

**Message:** Chaining Abuse

**Remediation:** Limit tool chaining depth and validate the output of each tool before passing it to the next. Require explicit user approval for multi-step chains.

---

### 🔴 HIGH: TM2

**Location:** `scripts/validate.py:137`  
**Confidence:** 75%  

**Message:** Chaining Abuse

**Remediation:** Limit tool chaining depth and validate the output of each tool before passing it to the next. Require explicit user approval for multi-step chains.

---

### 🔴 HIGH: E2

**Location:** `scripts/validate.py:151`  
**Confidence:** 90%  

**Message:** The script executes `printenv HF_TOKEN | head -c 4` to check whether the Hugging Face token is set, printing the first four characters to stdout. While only a prefix is exposed, this leaks part of a sensitive credential. In a shared or logged environment, even a partial token could aid an attacker in brute‑forcing the full token or serve as a reconnaissance vector. The check could be done without any output.

**Remediation:** Avoid printing any part of the token. Use a simple existence test such as `if [ -n "$HF_TOKEN" ]; then echo 'set'; else echo 'unset'; fi` or better, perform the check in Python with `os.environ.get('HF_TOKEN')` and only report boolean status.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:202`  
**Confidence:** 80%  

**Message:** The Docker command template uses a placeholder `<docker_image>` without enforcing a tag or digest. If the recipe cache or user input supplies an image reference without a tag (e.g., 'vllm/vllm-openai'), Docker will default to the `latest` tag, which is mutable and could be replaced with a malicious image by an attacker who compromises the registry or the cache. This could lead to arbitrary code execution inside the container with access to the host's GPU and the mounted Hugging Face cache, potentially leaking the HF_TOKEN environment variable. While the skill mentions pinned images for some models, it does not mandate it for all, leaving a supply chain risk.

**Remediation:** Always require a specific tag or digest in the `docker_image` value within `recipes_cache.json`. Validate that the image string matches a pattern like `^[^/]+/[^:]+:[a-zA-Z0-9_.-]+$` or ends with a digest (`@sha256:...`). If a tag is missing, append `:latest` only after user confirmation, or better, refuse to run. Additionally, pin the base image in the skill's own templates.

---

### 🟡 MEDIUM: E1

**Location:** `SKILL.md:242`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: E1

**Location:** `SKILL.md:287`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: RP1

**Location:** `SKILL.md:300`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -d'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:344`  
**Confidence:** 85%  

**Message:** The skill instructs the agent to run `sudo usermod -aG video,render $USER` to fix a permission error. This executes a privileged command that modifies system group membership. The skill does not explicitly require the agent to confirm with the user before running `sudo`, nor does it warn about the implications. In an agentic context, executing sudo without explicit user consent is a privilege-escalation risk: if the skill is compromised or misapplied, it could run arbitrary root commands. Even in this benign case, the command may unexpectedly require a password or hang.

**Remediation:** Add a mandatory confirmation step before any `sudo` command. The agent should explain the exact command and its purpose, ask the user to approve, and then execute it. Additionally, consider checking whether the user is already in the required groups (`groups $USER`) before attempting `sudo` to avoid unnecessary privileged operations.

---

### 🟡 MEDIUM: E1

**Location:** `data/recipes_cache.json:87`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: E1

**Location:** `data/recipes_cache.json:1928`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: E1

**Location:** `data/recipes_cache.json:8125`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:247`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:gemma4-0505-cu129'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:386`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:gemma4-0505-cu129'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:528`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:gemma4-0505-cu129'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:670`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:gemma4-0505-cu129'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:247`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:gemma4-0505-cu130'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:386`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:gemma4-0505-cu130'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:528`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:gemma4-0505-cu130'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:670`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:gemma4-0505-cu130'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:247`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai-rocm:latest'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:386`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai-rocm:latest'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:528`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai-rocm:latest'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:670`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai-rocm:latest'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:247`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai-cpu:latest-x86_64'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:528`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai-cpu:latest-x86_64'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:670`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai-cpu:latest-x86_64'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:247`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -itd'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:386`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -itd'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:528`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -itd'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:670`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -itd'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:739`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -itd'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:9155`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -itd'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: E1

**Location:** `data/recipes_cache.json:739`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:739`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:latest\n```\n\n##'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:7869`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:latest\n```\n\n##'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:848`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:995`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:1121`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:1252`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:3018`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:5249`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:8928`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:9060`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:9867`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:10589`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:10720`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RA2

**Location:** `data/recipes_cache.json:2648`  
**Confidence:** 60%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:3018`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --device=/dev/kfd'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:6863`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --device=/dev/kfd'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: E1

**Location:** `data/recipes_cache.json:3719`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:3821`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:mimov25-cu129\n```\n\n##'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:3926`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:mimov25-cu129\n```\n\n##'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: E1

**Location:** `data/recipes_cache.json:4651`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:5560`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:5642`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:5806`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: E1

**Location:** `data/recipes_cache.json:6135`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: E1

**Location:** `data/recipes_cache.json:6203`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: RA2

**Location:** `data/recipes_cache.json:6731`  
**Confidence:** 60%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:8232`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull --platform'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:8336`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull --platform'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:8232`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull ghcr.io/nvidia-ai-iot/vllm:latest-jetson-thor\n```\n\n##'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:8336`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull ghcr.io/nvidia-ai-iot/vllm:latest-jetson-thor\n```\n\n##'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:8558`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:nightly-8bff831f0aa239006f34b721e63e1340e3472067\n#'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:8784`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:v0.20.0\n#'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:8784`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:v0.20.0-cu129\n```\n\n##'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RA2

**Location:** `data/recipes_cache.json:8928`  
**Confidence:** 60%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:9155`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:laguna\n```\n\n###'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:9583`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker pull vllm/vllm-openai:stepfun37\n```\n\n##'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:9583`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -d'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `data/recipes_cache.json:9855`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run -it'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: E1

**Location:** `data/recipes_cache.json:9867`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: E1

**Location:** `data/recipes_cache.json:10964`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: AST4

**Location:** `evals/hooks.py:38–42`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: AST4

**Location:** `evals/hooks.py:70`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: PE2

**Location:** `reference.md:92`  
**Confidence:** 80%  

**Message:** The command uses `sudo` to write to a root-owned proc file. Agent-driven `sudo` commands are dangerous because they grant elevated privileges and may be triggered without full user awareness. If the skill or an embedded prompt is manipulated, the pattern could be abused to run privileged writes.

**Remediation:** Avoid `sudo` in the skill unless absolutely necessary. If privileged access is required, prompt the user for explicit confirmation and verify the exact command before execution. Prefer non-root alternatives where possible.

---

### 🟡 MEDIUM: SDI-2

**Location:** `reference.md:92`  
**Confidence:** 80%  

**Message:** The skill instructs `echo 0 | sudo tee /proc/sys/kernel/numa_balancing`, which modifies a system-wide kernel setting with root privileges. This is outside the stated scope of GPU detection/configuration and can affect all NUMA-sensitive workloads on the host. If executed automatically by an agent, it changes the host OS without explicit user consent.

**Remediation:** Remove this command from any automated flow. If included, require explicit user approval, explain side effects, and provide a restore command (`echo 1 | sudo tee /proc/sys/kernel/numa_balancing`). Prefer `sysctl -w kernel.numa_balancing=0` and avoid arbitrary writes via `sudo tee`.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/detect.py:32`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/validate.py:33`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/detect.py:44`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/validate.py:45`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: TT2

**Location:** `scripts/detect.py:44`  
**Confidence:** 80%  

**Message:** The SSH command is built using host and user values derived from CLI arguments or environment variables (`ROCM_SSH_HOST`, `ROCM_SSH_USER`). These values are not validated or sanitized. If an attacker can control `--host` or `ROCM_SSH_HOST`, they could craft a value starting with `-` (e.g., `-oProxyCommand=malicious_command`) that SSH interprets as an option rather than a hostname, leading to arbitrary command execution on the local machine. The `user` and `host` are concatenated into `user@host` and passed as a single argument, but SSH still parses leading dashes as options. This is a classic SSH option injection vulnerability.

**Remediation:** Validate `host` and `user` against a strict allowlist (e.g., hostname/IP regex, user alphanumeric with `_`). Do not allow values starting with `-`. Consider using `--` to separate options from the hostname, or use a higher-level library like `paramiko` that accepts separate host/user arguments. Additionally, avoid reading credentials from environment variables without explicit permission.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/detect.py:69`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/detect.py:70`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/detect.py:109`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/validate.py:79`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/validate.py:90`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/validate.py:114`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/validate.py:122`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/validate.py:130`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/validate.py:137`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/validate.py:147`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/sync_recipes.py:58–62`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/sync_recipes.py:117–120`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: TT2

**Location:** `scripts/validate.py:45`  
**Confidence:** 65%  

**Message:** Tainted flow: 'ssh' from os.environ.get (line 36, credential/environment) → subprocess.run (code execution)

**Remediation:** Validate tainted variables before passing them to sinks. Use allowlists, type checks, or sanitization functions on data from external sources.

---

### 🟡 MEDIUM: RP1

**Location:** `scripts/validate.py:167`  
**Confidence:** 75%  

**Message:** The script references the Docker image `vllm/vllm-openai-rocm:latest` in a suggestion to pull it. Using the mutable `latest` tag introduces a supply-chain risk: if the upstream image is updated with malicious content, a user following this advice could unknowingly deploy a compromised container. Although the script itself does not execute the pull, it encourages an insecure practice.

**Remediation:** Pin the image to a specific version or digest, e.g., `docker pull vllm/vllm-openai-rocm:v0.6.1` or `docker pull vllm/vllm-openai-rocm@sha256:...`.

---

### 🟢 LOW: SQP-2

**Location:** `SKILL.md:236`  
**Confidence:** 90%  

**Message:** The skill instructs the agent to run `docker rm -f <name>` to stop any container on a conflicting port. This force-removes a running container without first confirming with the user or checking whether the container is unrelated to the current task. It could delete a user's existing service, lose data, or disrupt other workloads on a shared host. The confirmation step (Step 5) does not cover this destructive side effect. This is a genuine missing-user-warning vulnerability. The intent is likely to clear the port, but it is negligent to do so without consent.

**Remediation:** Before removing any container found on a conflicting port, the agent should: (1) identify the container with `docker ps`, (2) show the user what will be removed, (3) ask for explicit confirmation, and (4) only then run `docker rm -f`. Also consider using `docker stop` and `docker rm` separately, and never force-remove without user approval.

---

### 🟢 LOW: SQP-2

**Location:** `reference.md:54–58`  
**Confidence:** 70%  

**Message:** The mandatory Docker flags include `--cap-add=SYS_PTRACE`, `--security-opt seccomp=unconfined`, and `--ipc=host`, which significantly reduce container isolation. The document provides no warning about the security implications, so a user may run this container with excessive privileges without understanding the risk.

**Remediation:** Add a prominent security warning. Use least-privilege Docker flags: drop all capabilities (`--cap-drop=ALL`), add only necessary capabilities, use a custom seccomp profile instead of `seccomp=unconfined`, and replace `--ipc=host` with `--shm-size` when possible. Ensure the container image is trusted.

---

### 🟢 LOW: SQP-2

**Location:** `reference.md:92`  
**Confidence:** 75%  

**Message:** The NUMA-disabling command is presented without any warning about side effects on other workloads or host stability. This is a system-wide kernel change and should not be a silent step in an agent skill.

**Remediation:** Add a warning and require user opt-in. Document that the change is non-persistent and can cause performance issues for non-GPU workloads.

---

## Inspection Completeness

| Metric | Value |
|--------|-------|
| Execution | successful |
| Status | partial |
| Coverage | 92.3% |
| Fully inspected | 12 |
| Partially inspected | 1 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| reference_unresolved | `SKILL.md:40-40` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:42-42` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:52-52` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:58-58` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:100-100` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:120-120` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:126-126` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:127-127` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:133-133` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:177-177` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:189-189` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:190-190` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:192-192` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:217-217` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:266-266` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:288-288` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:302-302` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:319-319` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:322-322` | A local path-like reference could not be resolved unambiguously. |
| obfuscated_instruction_text | `data/recipes_cache.json` | Obfuscated instruction text could not be fully evaluated by the deterministic layer. |
| static_parse_limit | `data/recipes_cache.json` | A security-relevant expression exceeded a bounded static parser's span limit. |

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
| degraded | `` |  |
| degraded | `` |  |
| completed | `` |  |
| degraded | `` |  |
| degraded | `` |  |
| degraded | `` |  |
| degraded | `` |  |
| completed | `` |  |
| degraded | `` |  |
| degraded | `` |  |
| degraded | `` |  |
| degraded | `` |  |
| degraded | `` |  |
| degraded | `` |  |
| degraded | `` |  |
| completed | `` |  |

### Limitations

- Analyzer static_patterns_agent_snooping status: degraded.
- Analyzer static_patterns_anti_refusal status: degraded.
- Analyzer static_patterns_deserialization status: degraded.
- Analyzer static_patterns_excessive_agency status: degraded.
- Analyzer static_patterns_harmful_content status: degraded.
- Analyzer static_patterns_memory_poisoning status: degraded.
- Analyzer static_patterns_privilege_escalation status: degraded.
- Analyzer static_patterns_prompt_injection status: degraded.
- Analyzer static_patterns_rogue_agent status: degraded.
- Analyzer static_patterns_ssrf status: degraded.
- Analyzer static_patterns_supply_chain status: degraded.
- Analyzer static_patterns_system_prompt_leakage status: degraded.
- Analyzer static_patterns_tool_misuse status: degraded.

## Metadata

- **Executable Scripts:** Yes

*Generated by SkillSpector v2.11.0*