# SkillSpector Security Report

**Skill:** tracelens-analysis-orchestrator  
**Source:** `/Users/kmittal/Code/GTM/amd-skills/skills/tracelens-analysis-orchestrator`  
**Scanned:** 2026-09-08 22:40:59 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 100/100 |
| Severity | CRITICAL |
| Recommendation | DO NOT INSTALL |

## Components (22)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `.federated.json` | json | 10 | No |
| `SKILL.md` | markdown | 55 | No |
| `agents/convolution-analyzer.md` | markdown | 186 | No |
| `agents/cpu-idle-analyzer.md` | markdown | 175 | No |
| `agents/elementwise-analyzer.md` | markdown | 159 | No |
| `agents/gemm-analyzer.md` | markdown | 150 | No |
| `agents/generic-op-analyzer.md` | markdown | 166 | No |
| `agents/kernel-fusion-analyzer.md` | markdown | 316 | No |
| `agents/model-identification-agent.md` | markdown | 106 | No |
| `agents/moe-analyzer.md` | markdown | 168 | No |
| `agents/multi-kernel-analyzer.md` | markdown | 272 | No |
| `agents/norm-analyzer.md` | markdown | 164 | No |
| `agents/reduce-analyzer.md` | markdown | 151 | No |
| `agents/sdpa-analyzer.md` | markdown | 212 | No |
| `agents/triton-analyzer.md` | markdown | 157 | No |
| `evals/evals.json` | json | 42 | No |
| `evals/hooks.py` | python | 170 | Yes |
| `evals/machine.yml` | yaml | 1 | No |
| `reference.md` | markdown | 652 | No |
| `skill-card.md` | markdown | 13 | No |
| `templates/analysis_template.md` | markdown | 501 | No |
| `templates/sub_agent_spec.md` | markdown | 347 | No |

## Issues (40)

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 97%  

**Message:** Description-behavior mismatch: declared purpose is 'Orchestrates modular PyTorch profiler trace analysis with TraceLens, including generating perf reports, preparing category data, running subagents in parallel, validating outputs, and writing analysis.md.' but code also performs: Generates perf reports, Prepares category data, Runs system-level and compute-kernel subagents in parallel, Validates outputs (only checks pass/fail from an external evaluator), Writes a prioritized stakeholder report (analysis.md) - instead expects agent to have written it.

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `Implements evaluation hooks for an agentic TraceLens workflow. It clones/installs TraceLens, creates an output directory, asserts existence/size of analysis.md, runs an external scoring script (workflow_scripted_evals.py), and checks that all rows PASS. It does not generate reports, run subagents, or perform any analysis itself.`
- **code_end_line:** `170`
- **code_path:** `evals/hooks.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: P2

**Location:** `agents/cpu-idle-analyzer.md:1`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `agents/generic-op-analyzer.md:1`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `agents/kernel-fusion-analyzer.md:1`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `agents/multi-kernel-analyzer.md:1`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: SDI-1

**Location:** `evals/hooks.py:105–169`  
**Confidence:** 90%  

**Message:** The manifest description claims the skill 'orchestrates modular PyTorch profiler trace analysis with TraceLens' including generating perf reports, running subagents, validating outputs, and writing analysis.md. The actual code in evals/hooks.py performs none of these operations; instead it clones a Git repository, creates a virtualenv, installs a package, and runs an external scoring script (workflow_scripted_evals.py) as part of an evaluation harness. This is a direct mismatch between the declared purpose and the code's behavior.

**Remediation:** Either update the manifest to accurately describe the skill's actual scope (an evaluation/setup utility), or refactor the skill so the code implements the advertised analysis orchestration.

---

### 🔴 HIGH: YR1

**Location:** `reference.md:145`  
**Confidence:** 95%  

**Message:** This is a direct match for the remote-bootstrap-execution pattern: `pip install git+https://github.com/AMD-AGI/TraceLens`. Pip automatically fetches and executes the package’s setup logic, which is effectively arbitrary code from a remote repository. The skill instructs the agent to perform this installation as part of its normal workflow whenever TraceLens is missing. Even though the repository is likely legitimate, the pattern is inherently dangerous: a hijacked account, a DNS poisoning attack, or a malicious contributor could cause arbitrary code to run in the agent’s environment with whatever privileges the agent has. Furthermore, the installation is not gated behind an explicit user consent step; the skill simply asks the user where to install, implying installation will proceed. The skill also does not pin a commit hash or verify a signature, so the fetched code can change over time. Given the high potential for remote code execution, this is a real vulnerability. The intent is likely benign (to enable the analysis), but the implementation is negligent from a security perspective. Remediation: (1) Do not allow the skill to install packages automatically; require the user to provide a pre-installed, verified TraceLens installation. (2) If installation must occur, use a pinned version from an official package index (PyPI) and verify its integrity. (3) Never fetch and execute code from an unpinned Git URL without explicit, audited user consent.

**Remediation:** Replace the pip install from Git URL with a requirement for a pre-existing installation. If installation is unavoidable, require explicit user confirmation and use a pinned, hash-verified distribution from a trusted package registry. Additionally, restrict the agent’s network access and sandbox any installation commands.

---

### 🔴 HIGH: SQP-2

**Location:** `reference.md:614–624`  
**Confidence:** 95%  

**Message:** The skill silently executes an optional Python script (`agent_extension.py`) with full privileges. No warning is provided to the user or the model that arbitrary code will be run. An attacker who controls the file path (via the `TL_EXTENSION` environment variable or a recursive search that may traverse input-controlled directories) can achieve arbitrary code execution within the agent's environment, leading to data theft, system compromise, or lateral movement.

**Remediation:** Add a clear warning in the skill description and before execution. Require explicit user confirmation before running any extension script. Validate the script's origin, integrity (checksum/signature), and content before execution. Consider running the extension in a sandboxed environment with restricted permissions.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:1`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:68`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:137`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:158`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:214`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:274`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:280`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:281`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:285`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:287`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:288`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:293`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:317`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:331`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:341`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:349`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:354`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:399`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:454`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:455`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:457`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:460`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:469`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/analysis_template.md:478`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/sub_agent_spec.md:1`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🔴 HIGH: P2

**Location:** `templates/sub_agent_spec.md:48`  
**Confidence:** 70%  

**Message:** Hidden Instructions

**Remediation:** Audit all comments and invisible characters. Remove any instructions that direct the agent to perform unauthorized actions. Use plain, reviewable content.

---

### 🟡 MEDIUM: LP3

**Location:** `SKILL.md:1`  
**Confidence:** 70%  

**Message:** The skill declares no tool scope (`permissions` or `allowed-tools`) while its instructions clearly require the ability to execute shell commands and manipulate environment variables (e.g., reading `cmd_prefix.txt`, running CLI commands, using `<prefix> tee`). This means the skill will rely on the agent's default tool permissions, which may grant broad or unrestricted access to the shell and filesystem. An attacker who can influence the skill content or inject additional instructions could leverage these over-broad capabilities to run arbitrary commands, exfiltrate data, or modify files outside the intended working directory. Even though the current skill content appears benign, missing least-privilege declarations is a real security weakness.

**Remediation:** Add an explicit tool scope to the skill frontmatter, such as:

```yaml
permissions:
  - shell
  - env
  - task
  - file_write
  - file_read
```

Additionally, restrict shell usage to specific command prefixes and directories (e.g., only within the trace output folder) if the underlying agent framework supports such constraints.

---

### 🟡 MEDIUM: AST4

**Location:** `evals/hooks.py:55–62`  
**Confidence:** 85%  

**Message:** The `_run()` function invokes `subprocess.run()` to execute commands whose arguments are partially derived from environment variables (`TRACELENS_REPO_URL`, `TRACELENS_REF`) and from a remote Git repository. While the use of a list prevents classic shell injection, the code subsequently runs `pip install -e` on the freshly cloned repository and later executes an arbitrary Python script (`workflow_scripted_evals.py`) from that same external source. If an attacker can control the repository URL/ref, or if the upstream repository is compromised, this results in arbitrary code execution with the privileges of the evaluation process. Additionally, `tarfile.extractall()` is called on an archive pulled from the repository without validating member paths or using a secure filter, enabling path traversal or symlink attacks. This is especially dangerous in an agentic skill context where the agent may invoke the skill autonomously.

**Remediation:** Pin the external repository to a known-good commit SHA, validate the repository URL against an allowlist, verify signed/checksummed artifacts, extract tar archives with `filter='data'` and reject unsafe member names, run all external setup/evaluation in a disposable sandboxed container with no network access to internal resources, and pass `--` to git/subprocess to prevent option injection.

---

### 🟡 MEDIUM: EA2

**Location:** `reference.md:76`  
**Confidence:** 75%  

**Message:** Autonomous Decision Making

**Remediation:** Add human-in-the-loop confirmation for destructive, irreversible, or high-impact operations. Never auto-execute commands that modify files, send data, or alter system state.

---

### 🟡 MEDIUM: SQP-2

**Location:** `reference.md:116–153`  
**Confidence:** 90%  

**Message:** This finding concerns the lack of user-facing warnings about the skill’s side effects. The specification describes executing remote shell commands over SSH and Docker (`ssh <node> ...`, `docker exec ...`), running Python scripts, writing files to the output directory, and installing packages via pip. None of these actions are accompanied by a prominent warning to the user that the agent will be performing privileged operations on their systems. Without such disclosure, a user may assume the skill only reads and analyzes a local trace file, when in reality it can remotely execute commands, alter environments, and generate files. This is especially problematic in shared or production environments. The omission appears negligent rather than malicious—the author likely focused on functionality—but it constitutes a security flaw because users cannot make informed decisions about what the skill will do. Remediation: Add a prominent “Safety & Side Effects” section to the skill description that explicitly lists: (a) remote SSH/Docker execution, (b) pip installation of third-party packages, (c) creation of virtual environments, and (d) file writes to arbitrary directories. Require the agent to confirm with the user before performing any of these actions if they were not explicitly authorized.

**Remediation:** Update the skill manifest and top-level documentation to clearly enumerate all side-effecting operations. Ensure the agent prompts for user confirmation before executing remote commands or installing software, especially when those actions go beyond the user’s original request.

---

### 🟡 MEDIUM: SDI-2

**Location:** `reference.md:144–152`  
**Confidence:** 85%  

**Message:** The skill’s declared purpose is to orchestrate trace analysis using an existing TraceLens installation. However, the skill contains instructions to install TraceLens directly from a remote Git repository (`pip install git+https://github.com/AMD-AGI/TraceLens`) and to create Python virtual environments when the package is missing. These actions are not mentioned in the skill description, creating an unjustified capability expansion. An agent following these instructions would perform network‑based downloads, execute arbitrary install-time code (via pip), and modify the local environment—without clear user consent or prior disclosure. While the target repository appears to be the official one, this behavior is dangerous because it bypasses normal dependency management, introduces supply-chain risk, and violates the principle of least privilege. Remediation: (1) Remove automatic installation from the skill; require the user to pre-install TraceLens. (2) If installation must be supported, require explicit user confirmation before any network access or package installation. (3) Pin the exact commit/tag and validate a cryptographic hash before installing.

**Remediation:** Remove or gate behind explicit opt-in the ability to pip‑install from a remote Git URL. Clearly document that the skill may install dependencies and create virtual environments. Use a pinned, vetted release from PyPI or a locked commit, and obtain user approval before executing any install command.

---

### 🟢 LOW: SSD-1

**Location:** `reference.md:615–624`  
**Confidence:** 98%  

**Message:** Step 11.2 instructs the model to execute an arbitrary Python script whose location is resolved from an environment variable or recursive directory search, while explicitly telling the model 'does not need to inspect or reason about it'. This suppresses natural caution and enables blind execution of untrusted code. Because the path is attacker-influenceable, this creates a critical arbitrary-code-execution vector that bypasses security review.

**Remediation:** Remove the directive to skip inspection. Before execution, the agent must verify the script's provenance and optionally display its contents for user approval. Restrict the search path to a dedicated, user-confirmed directory. Use allowlisting or require a cryptographic signature. If possible, isolate the execution in a container or virtual environment.

---

## Inspection Completeness

| Metric | Value |
|--------|-------|
| Execution | successful |
| Status | partial |
| Coverage | 95.5% |
| Fully inspected | 21 |
| Partially inspected | 1 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| reference_unresolved | `SKILL.md:21-21` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:37-37` | A local path-like reference could not be resolved unambiguously. |
| static_parse_limit | `agents/convolution-analyzer.md` | A security-relevant expression exceeded a bounded static parser's span limit. |

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