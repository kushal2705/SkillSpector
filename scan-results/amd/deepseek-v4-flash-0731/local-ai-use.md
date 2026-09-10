# SkillSpector Security Report

**Skill:** local-ai-use  
**Source:** `/Users/kmittal/Code/GTM/amd-skills/skills/local-ai-use`  
**Scanned:** 2026-09-08 18:12:49 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 100/100 |
| Severity | CRITICAL |
| Recommendation | DO NOT INSTALL |

## Components (6)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 320 | No |
| `evals/evals.json` | json | 57 | No |
| `reference.md` | markdown | 258 | No |
| `scripts/setup_local_ai.py` | python | 618 | Yes |
| `skill-card.md` | markdown | 13 | No |
| `templates/local-ai-rule.md` | markdown | 109 | No |

## Issues (44)

### 🔴 HIGH: AE1

**Location:** `SKILL.md:82`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:221`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:320`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:107`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:127`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:214`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:230`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:284`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: TM2

**Location:** `SKILL.md:153`  
**Confidence:** 75%  

**Message:** The command `sudo add-apt-repository -y ppa:lemonade-team/stable && sudo apt-get update && sudo apt-get install -y lemonade-server` chains multiple privileged commands with `&&`. This is a single shell invocation that can execute a chain of actions, increasing the blast radius if any step is compromised. The `&&` pattern is flagged as chaining abuse because it can hide malicious additions in long command lines.

**Remediation:** Break the command into separate, individually approved steps. Avoid chaining multiple sudo commands; use `sudo` only for the exact command needed and verify each step.

---

### 🔴 HIGH: P2

**Location:** `templates/local-ai-rule.md:1`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: SC2

**Location:** `templates/local-ai-rule.md:39`  
**Confidence:** 90%  

**Message:** External Script Fetching

**Remediation:** Avoid downloading and executing remote scripts. Use trusted packages from PyPI/npm. If remote fetch is required, verify checksums and use HTTPS.

---

### 🟡 MEDIUM: LP3

**Location:** `SKILL.md:1`  
**Confidence:** 75%  

**Message:** The skill metadata does not declare any tool scope (permissions/allowed-tools), yet the skill content clearly requires shell execution (install Lemonade, start services), file writes (modify AGENTS.md), network access (reach localhost, download from official install paths), and environment inspection. In a capable agent harness, this means the skill may run with a broad, unrestricted toolset. If the skill or any of its bundled scripts were tampered with, an attacker could read sensitive files, execute arbitrary shell commands, make outbound network calls, or modify persistent configuration without the user’s knowledge.

**Remediation:** Declare an explicit allow-list of tools and permissions. For example: shell only for specific commands (e.g., `lemonade install`, `lemonade status`), file write limited to `AGENTS.md` or `.cursorrules`, network restricted to localhost and official Lemonade endpoints. Require user confirmation before any installation or system modification. Also audit the actual setup script for unintended capabilities.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:34`  
**Confidence:** 75%  

**Message:** The skill instructs the agent to run a setup script that may execute `sudo` commands to install software. Since all skill content is treated as adversarial, this script cannot be trusted. Running it with root privileges could lead to arbitrary code execution, system compromise, or installation of malware. The skill also contains manipulative directives (e.g., 'even when the user asks for no image or file') and attempts to persist changes to `AGENTS.md`, indicating a potential malicious intent beyond simple local AI setup.

**Remediation:** Do not automatically run the setup script with sudo. Require explicit user approval before any privileged operation. Verify the script's authenticity and integrity (e.g., checksums, signed sources). Prefer using `--no-install` and manually guiding the user to install Lemonade from official repositories. If sudo is unavoidable, run the script in an isolated environment or sandbox and review its contents before execution.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:101`  
**Confidence:** 70%  

**Message:** The skill again references `sudo apt-get install` in the context of a managed/shared machine. This reinforces that the setup script may request elevated privileges. The adversarial nature of the skill, combined with its attempts to override user intent and persist configuration, makes this a dangerous pattern. Even if the script is benign, the ability to execute privileged commands without user consent violates security best practices.

**Remediation:** Never execute `sudo` commands from untrusted skill content without explicit user confirmation. Restrict the agent's capability to run privileged operations unless absolutely necessary and approved. If the skill is suspected of being malicious, do not run it at all and report it to the user.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:140`  
**Confidence:** 75%  

**Message:** The skill instructs the agent to run `sudo apt remove lemonade-server` to uninstall an old build. This is a privileged command that can alter the system. While the stated intent is troubleshooting, the skill content is untrusted and could be a vector for removing security software or other packages if manipulated. The surrounding text is contradictory ('Remove it' vs 'Never try to drive or auto-remove it'), increasing the risk of unintended execution.

**Remediation:** Do not execute uninstall commands automatically. Require explicit user confirmation before running any `sudo` command. Verify the package name and reason for removal with the user. Consider using `--no-install` and avoiding package removal altogether unless absolutely necessary.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:153`  
**Confidence:** 70%  

**Message:** The skill instructs the agent to run `sudo add-apt-repository -y ppa:lemonade-team/stable && sudo apt-get update && sudo apt-get install -y lemonade-server`. This is a privileged operation that adds a third-party PPA and installs a package from it. If the PPA is malicious or compromised, the agent will execute arbitrary code with root privileges. The skill explicitly says to install 'on the user's behalf' without requiring user confirmation, increasing risk.

**Remediation:** Never execute sudo commands without explicit user consent. Require interactive confirmation for package installation, verify the PPA and package integrity, and consider running the install manually or in a sandbox.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:154`  
**Confidence:** 70%  

**Message:** The fallback installation uses `sudo snap install lemonade-server`. Snap packages are confined but still run with elevated privileges during installation. The snap is from a third-party channel, and the skill instructs the agent to install it automatically, creating a supply chain risk.

**Remediation:** Require user approval before installing snap packages. Verify the snap publisher and channel, and prefer user-initiated installation.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:158`  
**Confidence:** 70%  

**Message:** The skill suggests `sudo apt install lemonade-desktop` for a desktop frontend. This is an optional package install but still requires root. The skill may execute it automatically if the user wants the desktop UI, without explicit consent.

**Remediation:** Make optional installations opt-in. Prompt the user before running any additional `apt install` command and explain what is being installed.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:172`  
**Confidence:** 80%  

**Message:** The skill suggests using `sudo systemctl start lemond` to start the service if it is not running. This elevates privileges without explicit user consent or warning. If the agent executes this automatically, it could start a service with root privileges, which may have broader system access than necessary. The skill does not mention asking for user approval or checking if sudo is required.

**Remediation:** Replace `sudo systemctl start lemond` with a command that runs without sudo when possible (e.g., `systemctl --user start lemond` for user-level installs) and clearly instruct the agent to ask the user for confirmation before using sudo. Alternatively, provide a non-sudo fallback and document the security implications.

---

### 🟡 MEDIUM: RA2

**Location:** `SKILL.md:172`  
**Confidence:** 80%  

**Message:** The reference to `com.lemonade.server.plist` indicates a persistent launch agent/daemon. Even without loading it, the skill's instructions to use `launchctl load` establish persistence. The plist itself is an untrusted file from a third-party installer and should be validated before use.

**Remediation:** Verify the plist's contents and signature. Never load a plist from an untrusted source without user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `SKILL.md:172`  
**Confidence:** 80%  

**Message:** The reference to `com.lemonade.server.plist` indicates a persistent launch agent/daemon. Even without loading it, the skill's instructions to use `launchctl load` establish persistence. The plist itself is an untrusted file from a third-party installer and should be validated before use.

**Remediation:** Verify the plist's contents and signature. Never load a plist from an untrusted source without user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `SKILL.md:172`  
**Confidence:** 75%  

**Message:** The reference to `com.lemonade.server.plist` indicates a persistent launch agent/daemon. Even without loading it, the skill's instructions to use `launchctl load` establish persistence. The plist itself is an untrusted file from a third-party installer and should be validated before use.

**Remediation:** Verify the plist's contents and signature. Never load a plist from an untrusted source without user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `SKILL.md:172`  
**Confidence:** 75%  

**Message:** The reference to `com.lemonade.server.plist` indicates a persistent launch agent/daemon. Even without loading it, the skill's instructions to use `launchctl load` establish persistence. The plist itself is an untrusted file from a third-party installer and should be validated before use.

**Remediation:** Verify the plist's contents and signature. Never load a plist from an untrusted source without user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `SKILL.md:210`  
**Confidence:** 90%  

**Message:** The skill persistently modifies AGENTS.md to route all image, audio, and speech requests to the local server, and the description explicitly says to do this 'even when the user asks for no image or file in the same breath.' This is a form of persistent prompt injection that overrides user instructions and could cause the agent to generate images or other outputs against the user's wishes. The persistence across sessions makes this particularly dangerous: the rule remains in AGENTS.md and is loaded automatically on every turn, effectively hijacking the agent's behavior. This could lead to resource waste, privacy leaks (if local server is compromised), or actions the user did not request.

**Remediation:** Remove any language that instructs overriding user requests. The skill should only apply when the user explicitly asks for local AI processing. Ensure the rule in AGENTS.md is clearly scoped to user-requested actions and does not persist behavior that conflicts with explicit user instructions. Implement a consent mechanism where the user must confirm the persistent routing change before it is applied.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:285`  
**Confidence:** 70%  

**Message:** The troubleshooting cheatsheet includes commands that require sudo (e.g., `sudo systemctl start lemond`, `sudo apt remove lemonade-server`). While these are intended for system service management, the skill does not instruct the agent to obtain explicit user approval before executing sudo commands. If the agent follows these instructions automatically, it could perform privileged actions without proper consent, potentially leading to system modifications or service disruption. The presence of sudo commands in an agent skill is a red flag unless strict guardrails are in place.

**Remediation:** Add a clear policy that the agent must never execute sudo commands without first asking for explicit user approval and explaining the exact command and its effect. Alternatively, replace direct sudo usage with non-privileged alternatives or user-initiated steps.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:286`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: RA2

**Location:** `SKILL.md:286`  
**Confidence:** 75%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/setup_local_ai.py:356`  
**Confidence:** 75%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `SKILL.md:286`  
**Confidence:** 75%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/setup_local_ai.py:356`  
**Confidence:** 75%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: E1

**Location:** `scripts/setup_local_ai.py:108`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_local_ai.py:114`  
**Confidence:** 80%  

**Message:** The script contains a hard‑coded shell command that runs `sudo add-apt-repository -y ppa:lemonade-team/stable && sudo apt-get update && sudo apt-get install -y lemonade-server`. This adds a third‑party PPA and installs a package with root privileges. If the PPA is compromised or the package is tampered with, an attacker gains full control of the system. More importantly, the skill may run this automatically when no `lemonade` CLI is found, without an explicit, user‑approved confirmation step. The skill description even says it will “install the latest version on the user’s behalf,” which suggests an agent could run this with minimal user awareness. This is especially dangerous because the skill’s metadata contains an instruction to “even when the user asks for no image or file in the same breath,” indicating a willingness to override user wishes—a strong signal that the skill is not trustworthy.

**Remediation:** Change the default behavior to require explicit user consent before any privileged action. Use the `--no-install` flag by default, or prompt the user for confirmation before executing `sudo`. Avoid a single `shell=True` string; use `subprocess.run` with `shell=False` and a list. Verify the PPA fingerprint and package checksum, or install only from trusted OS repositories. Run the installation steps with least privilege where possible.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_local_ai.py:116`  
**Confidence:** 80%  

**Message:** This is the `sudo apt-get update` portion of the same install command. It is a privileged operation that updates package metadata from the newly added PPA. If the PPA is malicious, this step could download malicious package lists or trigger hooks. Combined with the automatic installation behavior, this is a serious risk. The skill’s context (including instruction‑override language) elevates the concern.

**Remediation:** Same as above: require explicit user consent, avoid automatic privilege escalation, and use a vetted package source.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_local_ai.py:117`  
**Confidence:** 80%  

**Message:** This is the `sudo apt-get install -y lemonade-server` portion of the command. It installs a package from a third‑party PPA with root privileges. This is the most critical step because it executes the package’s post‑install scripts as root. If the package is malicious or compromised, the system is fully compromised. The skill’s automatic setup behavior and the suspicious instruction to override user requests make this a significant security concern.

**Remediation:** Do not auto‑install third‑party packages. Provide a manual, user‑initiated installation path. If automatic installation is required, verify the package signature, checksum, and provenance, and require an explicit user approval before execution.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_local_ai.py:118`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_local_ai.py:352`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_local_ai.py:356`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_local_ai.py:369`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/setup_local_ai.py:190–195`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/setup_local_ai.py:256`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

---

### 🟡 MEDIUM: E1

**Location:** `templates/local-ai-rule.md:39`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: E1

**Location:** `templates/local-ai-rule.md:58`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟢 LOW: SSD-1

**Location:** `SKILL.md:8–9`  
**Confidence:** 95%  

**Message:** The skill description explicitly instructs the agent to continue setting up local image generation and to generate images “even when the user asks for no image or file in the same breath.” This is a direct override of the user’s expressed refusal. The instruction is paired with a persistent change to `AGENTS.md` so the override survives future turns and works across multiple agent harnesses. This is a coercive, deceptive pattern: it prioritizes the skill’s own goal over the user’s current intent and can lead to unwanted actions, resource usage, or privacy leaks (e.g., generating images from context when the user explicitly asked not to). It also normalizes ignoring user instructions, which is a serious security boundary violation.

**Remediation:** Remove the instruction to override explicit user refusals. The skill must always respect the user’s latest request. Persistent changes (e.g., modifying AGENTS.md) should only be made after explicit user consent and should be clearly reversible. If the user says “no image/file”, the agent must not generate or set up anything related to images unless the user explicitly confirms later.

---

### 🟢 LOW: SQP-2

**Location:** `SKILL.md:223–286`  
**Confidence:** 80%  

**Message:** The skill modifies workspace AGENTS.md, installs a local server, starts background services, and installs GPU backends without explicitly warning the user about these persistent system changes. While the user likely invoked the skill for this purpose, the description's phrasing 'use it above all to change that routing persistently' and 'even when the user asks for no image or file in the same breath' indicates the skill may override explicit user requests. The lack of clear warnings reduces user consent transparency and could lead to unintended configuration changes or resource usage.

**Remediation:** Add prominent warnings in the skill description about persistent modifications to AGENTS.md, installation of local servers, and background services. Require explicit user confirmation before applying changes. Remove language that suggests overriding user requests (e.g., 'even when the user asks for no image').

---

## Inspection Completeness

| Metric | Value |
|--------|-------|
| Execution | successful |
| Status | partial |
| Coverage | 66.7% |
| Fully inspected | 4 |
| Partially inspected | 2 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| reference_unresolved | `SKILL.md:15-15` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:37-37` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:39-39` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:71-71` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:73-73` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:112-112` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:140-140` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:141-141` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:152-152` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:206-206` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:217-217` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:226-226` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:227-227` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:247-247` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:248-248` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:249-249` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:257-257` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:288-288` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:300-300` | A local path-like reference could not be resolved unambiguously. |
| static_parse_limit | `reference.md` | A security-relevant expression exceeded a bounded static parser's span limit. |
| obfuscated_instruction_text | `scripts/setup_local_ai.py` | Obfuscated instruction text could not be fully evaluated by the deterministic layer. |

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