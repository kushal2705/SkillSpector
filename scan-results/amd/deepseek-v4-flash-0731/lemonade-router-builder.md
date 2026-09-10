# SkillSpector Security Report

**Skill:** lemonade-router-builder  
**Source:** `/Users/kmittal/Code/GTM/amd-skills/skills/lemonade-router-builder`  
**Scanned:** 2026-09-04 20:08:50 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 100/100 |
| Severity | CRITICAL |
| Recommendation | DO NOT INSTALL |

## Components (6)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 308 | No |
| `evals/evals.json` | json | 66 | No |
| `examples.md` | markdown | 472 | No |
| `reference.md` | markdown | 228 | No |
| `scripts/validate.py` | python | 512 | Yes |
| `skill-card.md` | markdown | 13 | No |

## Issues (12)

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 95%  

**Message:** Description-behavior mismatch: declared purpose is 'Generates and validates a collection.router policy JSON from natural-language routing intent.' but code also performs: generation from natural-language.

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `Validates an existing collection.router policy JSON against structural and numeric rules; does not generate JSON from natural-language input.`
- **code_end_line:** `512`
- **code_path:** `scripts/validate.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:32`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:223`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:224`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:308`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: P6

**Location:** `SKILL.md:262`  
**Confidence:** 85%  

**Message:** Direct Prompt Extraction

**Remediation:** Remove any instructions that reveal, print, or output system prompts or internal rules. System instructions should never be exposed to end users.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:306`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: SDI-1

**Location:** `reference.md:178–203`  
**Confidence:** 90%  

**Message:** The manifest explicitly states the skill 'does not register it or call the live server,' but the reference.md includes a full section on registering, invoking, and tracing policies with curl commands, and instructs the skill to 'use it to demonstrate each rule to the user.' This is a clear scope contradiction. If the skill follows these instructions, it will make live HTTP POST requests to a local server, potentially registering policies, overwriting existing ones, or sending data without explicit user consent. The agent may also be tricked into sending data to a different host if the URL is manipulated via prompt injection. This violates the declared safe behavior and introduces unintended side effects.

**Remediation:** Update the manifest to accurately describe the skill's capabilities, or remove the registration/invocation instructions from the reference. Ensure the skill strictly generates and validates JSON without executing network commands. If live testing is required, obtain explicit user consent before making any server calls.

---

### 🟡 MEDIUM: LP3

**Location:** `SKILL.md:1`  
**Confidence:** 80%  

**Message:** The skill instructs the agent to execute a local Python script (`python scripts/validate.py router.json`) without declaring any tool permissions or allowed-tools. This is an unconstrained shell-capable action. Although the intended use is offline validation, the skill content is not executed in a sandboxed context, and the script itself is not audited here. If the script were malicious (or tampered with), the agent would run arbitrary code on the host. It also violates least-privilege best practices for agent skills.

**Remediation:** Declare explicit permissions/allowed-tools for running shell commands, or better, avoid direct shell execution entirely. If validation must run, use a hardened, integrity-checked script and limit it to a read-only operation on the generated JSON. Alternatively, move validation logic into the agent's own code rather than delegating to an external script.

---

### 🟡 MEDIUM: E1

**Location:** `SKILL.md:216`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: E1

**Location:** `reference.md:182`  
**Confidence:** 60%  

**Message:** External Transmission

**Remediation:** Verify the destination URL is trusted and necessary. Remove or replace with documented APIs. Ensure no secrets, tokens, or PII are transmitted.

---

### 🟡 MEDIUM: AST4

**Location:** `scripts/validate.py:119`  
**Confidence:** 70%  

**Message:** subprocess module call

**Remediation:** Use subprocess.run() with shell=False and an explicit argument list. Validate all inputs and avoid passing user-controlled data to commands.

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
| reference_unresolved | `SKILL.md:5-5` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:8-8` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:10-10` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:12-12` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:18-18` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:39-39` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:40-40` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:42-42` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:43-43` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:68-68` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:114-114` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:158-158` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:169-169` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:176-176` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:213-213` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:224-224` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:239-239` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:248-248` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:252-252` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:266-266` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:284-284` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:287-287` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:296-296` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:301-301` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:304-304` | A local path-like reference could not be resolved unambiguously. |
| static_parse_limit | `examples.md` | A security-relevant expression exceeded a bounded static parser's span limit. |
| static_parse_limit | `scripts/validate.py` | A security-relevant expression exceeded a bounded static parser's span limit. |

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