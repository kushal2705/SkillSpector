# SkillSpector Security Report

**Skill:** xpu-deploy-plan  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/xpu-deploy-plan`  
**Scanned:** 2026-09-02 02:14:08 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 100/100 |
| Severity | CRITICAL |
| Recommendation | DO NOT INSTALL |

## Components (2)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 166 | No |
| `scripts/build_plan.sh` | shell | 383 | Yes |

## Issues (14)

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 85%  

**Message:** The skill’s description promises ‘one exact launch command’ in the generated PLAN.md, but static analysis reveals that for SGLang and PyTorch runtimes the script only inserts a placeholder pointing to the corresponding runtime skill instead of generating a concrete command. This mismatch undermines the trust contract with the user: an agent relying on this skill may present an incomplete or misleading plan, prompting the user to manually fill in gaps or run unverified commands. In a worst-case scenario, an attacker who compromises the script or manipulates the skill repository could replace the placeholder with a malicious command (e.g., a container image with a backdoor or a command that exposes sensitive host resources), and the agent would faithfully present it as the ‘exact’ launch command. Even without malicious tampering, the inconsistency creates operational risks—users may proceed with faulty configurations, leading to service disruption, data leakage, or improper GPU/container isolation. The skill context (orchestration across multiple runtimes) makes this particularly dangerous because the user relies on the skill to produce a reliable, single source of truth for deployment.

**Remediation:** Either extend `build_plan.sh` to invoke the launch emitters for SGLang and PyTorch (matching the vLLM path) so a true exact command is generated for all supported runtimes, or revise the skill description to explicitly state that exact launch commands are only provided for vLLM and that SGLang/PyTorch plans will reference the relevant runtime skill. Additionally, ensure the generated PLAN.md clearly labels placeholders as such and never presents them as executable commands without validation.

**Evidence:**
- **actual_behavior_summary:** `Executes preflight, fit, and config recommendation scripts (for vLLM only), generates a plan document. Provides an exact launch command only for vLLM; for sglang/torch it merely references their SKILL.md without producing an exact command.`
- **code_end_line:** `383`
- **code_path:** `scripts/build_plan.sh`
- **code_start_line:** `1`

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:36`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:40`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:45`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🟡 MEDIUM: LP3

**Location:** `SKILL.md:1`  
**Confidence:** 80%  

**Message:** The skill declares no tool scope (no 'permissions' or 'allowed-tools' metadata) but its primary entry point (`scripts/build_plan.sh`) invokes shell commands, subprocesses, and writes files. In an agentic environment, missing permission declarations may cause the agent framework to grant broad or implicit capabilities, violating least-privilege principles. While the script itself is designed to run shell commands, the absence of explicit scoping increases the attack surface if the script is ever compromised or if arguments are influenced by untrusted input (e.g., model IDs or paths). A malicious or modified version of this skill could abuse the undisclosed shell capability to execute arbitrary commands, escalate privileges, or exfiltrate data without the user’s awareness. The skill context (a deployment planner) makes shell usage expected, but the lack of declared scope means the system cannot properly sandbox or audit its actions.

**Remediation:** Add a `permissions` or `allowed-tools` field to the skill metadata explicitly listing shell execution (e.g., `permissions: ["shell"]` or `allowed-tools: ["bash"]`). Additionally, harden the script by validating and sanitizing all external inputs, avoiding dynamic evaluation of untrusted strings, and minimizing the script’s writable directories to the designated `.out/` area.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/build_plan.sh:58`  
**Confidence:** 60%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/build_plan.sh:113`  
**Confidence:** 60%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: AS3

**Location:** `scripts/build_plan.sh:257`  
**Confidence:** 80%  

**Message:** Skill Enumeration

**Remediation:** Remove all code or instructions that list or read other skills' files or directories. Skills should operate independently; cross-skill access is a privilege escalation.

---

### 🟡 MEDIUM: AS3

**Location:** `scripts/build_plan.sh:260`  
**Confidence:** 80%  

**Message:** Skill Enumeration

**Remediation:** Remove all code or instructions that list or read other skills' files or directories. Skills should operate independently; cross-skill access is a privilege escalation.

---

### 🟡 MEDIUM: AS3

**Location:** `scripts/build_plan.sh:266`  
**Confidence:** 80%  

**Message:** Skill Enumeration

**Remediation:** Remove all code or instructions that list or read other skills' files or directories. Skills should operate independently; cross-skill access is a privilege escalation.

---

### 🟡 MEDIUM: RP1

**Location:** `scripts/build_plan.sh:266`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run command'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: AS3

**Location:** `scripts/build_plan.sh:271`  
**Confidence:** 80%  

**Message:** Skill Enumeration

**Remediation:** Remove all code or instructions that list or read other skills' files or directories. Skills should operate independently; cross-skill access is a privilege escalation.

---

### 🟡 MEDIUM: E1

**Location:** `scripts/build_plan.sh:348`  
**Confidence:** 70%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟢 LOW: SDI-1

**Location:** `scripts/build_plan.sh:265–275`  
**Confidence:** 80%  

**Message:** Manifest states the skill chains and calls the selected runtime skill (vllm-xpu-run / sglang-xpu-run / torch-xpu-run) and writes a single exact launch command. However, for sglang and torch runtimes the script does not invoke any runtime-skill script; it only assigns a static reference to the corresponding SKILL.md (lines 266, 271). Consequently, the generated PLAN.md contains a textual pointer instead of an exact launch command (line 343). This deviates from the advertised behavior of calling each runtime skill and producing a precise command.

**Remediation:** Either modify the script to invoke the appropriate emit_launch.sh (or equivalent) for sglang and torch, or update the manifest description to clarify that only vllm receives an executable command while other runtimes receive guidance to consult their respective skill documentation.

---

## Inspection Completeness

| Metric | Value |
|--------|-------|
| Execution | successful |
| Status | partial |
| Coverage | 50.0% |
| Fully inspected | 1 |
| Partially inspected | 1 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| reference_unresolved | `SKILL.md:3-3` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:10-10` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:20-20` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:32-32` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:41-41` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:47-47` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:53-53` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:54-54` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:59-59` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:65-65` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:66-66` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:68-68` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:69-69` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:70-70` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:73-73` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:91-91` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:99-99` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:108-108` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:126-126` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:138-138` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:142-142` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:144-144` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:165-165` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:166-166` | A local path-like reference could not be resolved unambiguously. |
| static_parse_limit | `scripts/build_plan.sh` | A security-relevant expression exceeded a bounded static parser's span limit. |

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