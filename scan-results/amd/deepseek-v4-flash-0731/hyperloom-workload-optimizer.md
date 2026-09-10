# SkillSpector Security Report

**Skill:** hyperloom-workload-optimizer  
**Source:** `/Users/kmittal/Code/GTM/amd-skills/skills/hyperloom-workload-optimizer`  
**Scanned:** 2026-09-04 19:58:55 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 100/100 |
| Severity | CRITICAL |
| Recommendation | DO NOT INSTALL |

## Components (13)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 460 | No |
| `evals/evals.json` | json | 83 | No |
| `evals/machine.yml` | yaml | 1 | No |
| `reference.md` | markdown | 139 | No |
| `scripts/_env.sh` | shell | 60 | Yes |
| `scripts/launch.sh` | shell | 56 | Yes |
| `scripts/launch_health.sh` | shell | 69 | Yes |
| `scripts/preflight.py` | python | 280 | Yes |
| `scripts/resume.sh` | shell | 58 | Yes |
| `scripts/tests/test_launch_flow.sh` | shell | 243 | Yes |
| `scripts/tests/test_preflight.py` | python | 232 | Yes |
| `setup.md` | markdown | 115 | No |
| `skill-card.md` | markdown | 13 | No |

## Issues (39)

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 95%  

**Message:** Description-behavior mismatch: declared purpose is 'Autonomously optimizes end-to-end LLM inference throughput on AMD Instinct GPUs using the Hyperloom multi-agent optimizer, exploring levers, benchmarking, and returning the optimization stack.' but code also performs: The code does not autonomously optimize LLM inference throughput., The code does not explore levers, benchmark candidates, or return an optimization stack., The code is only a safety/launch gate, not the optimizer itself., The declared triggers for using the skill (e.g., running Hyperloom, kernel-agent, quantize-then-optimize) are not addressed by this code..

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `A preflight gate script that checks whether the GPUs are idle (model path exists, torch sees GPUs, no foreign serving processes, VRAM usage below a limit) before allowing an optimization run to start. It does not perform any optimization, benchmarking, or lever exploration.`
- **code_end_line:** `280`
- **code_path:** `scripts/preflight.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 100%  

**Message:** Description-behavior mismatch: declared purpose is 'Autonomously optimizes LLM inference throughput on AMD Instinct GPUs using the Hyperloom multi-agent optimizer, including benchmarking, kernel rewrites, and reporting validated gains.' but code also performs: No actual optimization is performed; the code is a test harness., No GPU, ROCm, vLLM/SGLang, or kernel-agent interactions occur., No benchmarking, levers exploration, or gain reporting is implemented., The code does not invoke Hyperloom; it only tests wrapper scripts with a stub..

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `A shell smoke test for launch.sh, launch_health.sh, and resume.sh. It uses a stub optimizer and fixtures to verify argument passing, health checks, resume behavior, and error handling without any GPU, Hyperloom wheel, or real optimization.`
- **code_end_line:** `243`
- **code_path:** `scripts/tests/test_launch_flow.sh`
- **code_start_line:** `1`

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 100%  

**Message:** Description-behavior mismatch: declared purpose is 'Autonomous LLM inference throughput optimizer for AMD Instinct GPUs using Hyperloom multi-agent system, exploring and benchmarking optimization levers.' but code also performs: No multi-agent optimization, benchmarking, or kernel rewriting logic exists in the provided code., The code does not interact with vLLM/SGLang, Quark, or any inference serving frameworks., It does not report validated gains or explore configuration parameters., Its primary purpose is testing a safety check, not performance optimization..

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `Regression test script for the IR-1 VRAM gate in preflight.py; verifies fail-closed behavior when amd-smi reports busy GPUs in various output shapes.`
- **code_end_line:** `232`
- **code_path:** `scripts/tests/test_preflight.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:70`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:149`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:458`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:80`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:84`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:412`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:459`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: PE3

**Location:** `SKILL.md:313`  
**Confidence:** 70%  

**Message:** The skill sources the `.env` file (`set -a; . "${INSTALL_DIR}/.env"; set +a`), which contains LLM API keys and other secrets. This is a credential access operation. While the skill explicitly avoids printing secrets, sourcing a file that may contain arbitrary content (if tampered) could lead to secret exfiltration or environment poisoning. The operation is necessary for the optimizer to function, but it is a high-risk pattern, especially in shared or untrusted environments. The author intended legitimate use, but the skill is a prime target for supply-chain attacks.

**Remediation:** Avoid sourcing `.env` directly. Instead, export the required variables explicitly from the agent's environment, or use a secure secret manager. If sourcing is unavoidable, validate the file's provenance and permissions, and consider reading only the specific variables needed (e.g., `grep` for known keys) rather than sourcing the whole file.

---

### 🔴 HIGH: PE3

**Location:** `scripts/_env.sh:23`  
**Confidence:** 60%  

**Message:** Credential Access

**Remediation:** Remove references to credential paths. Use environment variables or secrets managers. For docs, use placeholder paths (e.g., /path/to/config). Never load .env or token files in production code paths.

---

### 🔴 HIGH: PE3

**Location:** `scripts/_env.sh:27`  
**Confidence:** 60%  

**Message:** Credential Access

**Remediation:** Remove references to credential paths. Use environment variables or secrets managers. For docs, use placeholder paths (e.g., /path/to/config). Never load .env or token files in production code paths.

---

### 🔴 HIGH: PE3

**Location:** `scripts/tests/test_launch_flow.sh:93`  
**Confidence:** 60%  

**Message:** Credential Access

**Remediation:** Remove references to credential paths. Use environment variables or secrets managers. For docs, use placeholder paths (e.g., /path/to/config). Never load .env or token files in production code paths.

---

### 🔴 HIGH: PE3

**Location:** `scripts/tests/test_launch_flow.sh:82`  
**Confidence:** 60%  

**Message:** Credential Access

**Remediation:** Remove references to credential paths. Use environment variables or secrets managers. For docs, use placeholder paths (e.g., /path/to/config). Never load .env or token files in production code paths.

---

### 🔴 HIGH: PE3

**Location:** `scripts/tests/test_launch_flow.sh:92`  
**Confidence:** 60%  

**Message:** Credential Access

**Remediation:** Remove references to credential paths. Use environment variables or secrets managers. For docs, use placeholder paths (e.g., /path/to/config). Never load .env or token files in production code paths.

---

### 🔴 HIGH: TM1

**Location:** `scripts/tests/test_launch_flow.sh:207`  
**Confidence:** 95%  

**Message:** Tool Parameter Abuse

**Remediation:** Validate all tool parameters against an allowlist. Reject dangerous parameter values (shell=True, --force, -rf /) and use safe defaults.

---

### 🔴 HIGH: TM1

**Location:** `scripts/tests/test_launch_flow.sh:220`  
**Confidence:** 95%  

**Message:** Tool Parameter Abuse

**Remediation:** Validate all tool parameters against an allowlist. Reject dangerous parameter values (shell=True, --force, -rf /) and use safe defaults.

---

### 🔴 HIGH: TM1

**Location:** `scripts/tests/test_launch_flow.sh:233`  
**Confidence:** 95%  

**Message:** Tool Parameter Abuse

**Remediation:** Validate all tool parameters against an allowlist. Reject dangerous parameter values (shell=True, --force, -rf /) and use safe defaults.

---

### 🔴 HIGH: E2

**Location:** `scripts/tests/test_preflight.py:199`  
**Confidence:** 60%  

**Message:** Env Variable Harvesting

**Remediation:** Read only explicitly required environment variables by name. Avoid enumerating or copying the full environment, and never log or transmit credentials to untrusted destinations.

---

### 🟡 MEDIUM: LP3

**Location:** `SKILL.md:1`  
**Confidence:** 70%  

**Message:** The skill declares no explicit tool scope, yet its content clearly requires shell execution, environment manipulation, and file I/O. In agent frameworks, omitting a permission declaration can cause the runtime to default to a permissive policy, granting the skill more access than necessary. This is a defense-in-depth weakness: a tampered or compromised version of this skill could leverage the implicit broad permissions to run arbitrary commands, read sensitive files, or modify the environment. The author likely omitted the field by oversight, not malice.

**Remediation:** Add a `permissions` or `allowed-tools` metadata block to the skill frontmatter, explicitly listing only the required capabilities (e.g., `shell`, `file_read`, `file_write`, `env`). Avoid wildcard grants.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/launch.sh:9`  
**Confidence:** 65%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/launch.sh:26`  
**Confidence:** 65%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/resume.sh:38`  
**Confidence:** 65%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `SKILL.md:356`  
**Confidence:** 65%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `SKILL.md:376`  
**Confidence:** 65%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/launch.sh:9`  
**Confidence:** 65%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/launch.sh:26`  
**Confidence:** 65%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/launch.sh:42`  
**Confidence:** 65%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/launch_health.sh:7`  
**Confidence:** 65%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/resume.sh:38`  
**Confidence:** 65%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/tests/test_launch_flow.sh:31`  
**Confidence:** 65%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/tests/test_launch_flow.sh:161`  
**Confidence:** 65%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/preflight.py:173–175`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: AS3

**Location:** `SKILL.md:75`  
**Confidence:** 80%  

**Message:** Skill Enumeration

**Remediation:** Remove all code or instructions that list or read other skills' files or directories. Skills should operate independently; cross-skill access is a privilege escalation.

---

### 🟡 MEDIUM: AS3

**Location:** `setup.md:38`  
**Confidence:** 80%  

**Message:** Skill Enumeration

**Remediation:** Remove all code or instructions that list or read other skills' files or directories. Skills should operate independently; cross-skill access is a privilege escalation.

---

### 🟡 MEDIUM: AS3

**Location:** `setup.md:48`  
**Confidence:** 80%  

**Message:** Skill Enumeration

**Remediation:** Remove all code or instructions that list or read other skills' files or directories. Skills should operate independently; cross-skill access is a privilege escalation.

---

### 🟡 MEDIUM: AS3

**Location:** `setup.md:57`  
**Confidence:** 80%  

**Message:** Skill Enumeration

**Remediation:** Remove all code or instructions that list or read other skills' files or directories. Skills should operate independently; cross-skill access is a privilege escalation.

---

### 🟡 MEDIUM: RP1

**Location:** `setup.md:89`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'Docker run mode'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

## Inspection Completeness

| Metric | Value |
|--------|-------|
| Execution | successful |
| Status | partial |
| Coverage | 76.9% |
| Fully inspected | 10 |
| Partially inspected | 3 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| static_parse_limit | `SKILL.md` | A security-relevant expression exceeded a bounded static parser's span limit. |
| reference_unresolved | `SKILL.md:6-6` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:7-7` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:11-11` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:15-15` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:61-61` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:62-62` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:75-75` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:88-88` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:89-89` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:90-90` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:91-91` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:92-92` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:93-93` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:100-100` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:106-106` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:134-134` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:141-141` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:145-145` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:156-156` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:179-179` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:185-185` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:203-203` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:218-218` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:269-269` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:274-274` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:284-284` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:331-331` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:342-342` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:365-365` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:369-369` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:379-379` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:395-395` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:407-407` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:410-410` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:411-411` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:426-426` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:430-430` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:441-441` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:453-453` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:460-460` | A local path-like reference could not be resolved unambiguously. |
| static_parse_limit | `reference.md` | A security-relevant expression exceeded a bounded static parser's span limit. |
| static_parse_limit | `setup.md` | A security-relevant expression exceeded a bounded static parser's span limit. |

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
| completed | `` |  |
| degraded | `` |  |
| completed | `` |  |

### Limitations

- Analyzer static_patterns_tool_misuse status: degraded.

## Metadata

- **Executable Scripts:** Yes

*Generated by SkillSpector v2.11.0*