# SkillSpector Security Report

**Skill:** xpu-system-setup  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/xpu-system-setup`  
**Scanned:** 2026-09-02 07:02:03 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 100/100 |
| Severity | CRITICAL |
| Recommendation | DO NOT INSTALL |

## Components (3)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 279 | No |
| `scripts/check_battlemage_prerequisites.sh` | shell | 402 | Yes |
| `scripts/setup_xpu_system.sh` | shell | 1005 | Yes |

## Issues (37)

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 90%  

**Message:** Similarly, the skill advertises Battlemage prerequisite handling (nomodeset removal, OEM kernel upgrade, runtime ≥26.18) but the referenced script `check_battlemage_prerequisites.sh` is not present in the skill bundle and the main script does not include these remediations. This gap means users following the instructions will attempt to use a non-existent script or expect automatic fixes that never occur. If a user manually applies the suggested `sed`/`update-grub`/reboot commands without proper validation, they could corrupt boot configuration or leave the system unbootable.

**Remediation:** Either ship the `check_battlemage_prerequisites.sh` script with the skill and integrate it into the main flow, or remove all Battlemage-related claims from the description until fully supported. Provide clear warnings when prerequisites are not met and do not offer manual steps that could be hazardous.

**Evidence:**
- **actual_behavior_summary:** `A diagnostic/fix script specifically for Intel Battlemage GPUs (B60/B70) on Ubuntu 24.04, checking hardware, GRUB nomodeset, kernel/xe driver, compute runtime, and xpu-smi; optionally applying targeted fixes (remove nomodeset, install OEM kernel, upgrade runtime) interactively.`
- **code_end_line:** `402`
- **code_path:** `scripts/check_battlemage_prerequisites.sh`
- **code_start_line:** `1`

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 80%  

**Message:** Similarly, the skill advertises Battlemage prerequisite handling (nomodeset removal, OEM kernel upgrade, runtime ≥26.18) but the referenced script `check_battlemage_prerequisites.sh` is not present in the skill bundle and the main script does not include these remediations. This gap means users following the instructions will attempt to use a non-existent script or expect automatic fixes that never occur. If a user manually applies the suggested `sed`/`update-grub`/reboot commands without proper validation, they could corrupt boot configuration or leave the system unbootable.

**Remediation:** Either ship the `check_battlemage_prerequisites.sh` script with the skill and integrate it into the main flow, or remove all Battlemage-related claims from the description until fully supported. Provide clear warnings when prerequisites are not met and do not offer manual steps that could be hazardous.

**Evidence:**
- **actual_behavior_summary:** `Implements all core setup steps (PPA, compute/media/pytorch packages, xpu-smi, groups, Docker) with detection, prompting, and verification. Does NOT contain any Battlemage-specific logic, nor references to check_battlemage_prerequisites.sh or nomodeset/kernel/runtime version handling.`
- **code_end_line:** `1005`
- **code_path:** `scripts/setup_xpu_system.sh`
- **code_start_line:** `1`

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:24`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: AE1

**Location:** `SKILL.md:167`  
**Confidence:** 100%  

**Message:** Referenced artifact was not completely inspected

**Remediation:** Make the referenced artifact locally available and fully analyzable, or remove the reference.

---

### 🔴 HIGH: TM2

**Location:** `SKILL.md:182`  
**Confidence:** 75%  

**Message:** Chaining Abuse

**Remediation:** Limit tool chaining depth and validate the output of each tool before passing it to the next. Require explicit user approval for multi-step chains.

---

### 🔴 HIGH: TM2

**Location:** `scripts/check_battlemage_prerequisites.sh:340`  
**Confidence:** 75%  

**Message:** Chaining Abuse

**Remediation:** Limit tool chaining depth and validate the output of each tool before passing it to the next. Require explicit user approval for multi-step chains.

---

### 🟡 MEDIUM: LP3

**Location:** `SKILL.md:1`  
**Confidence:** 70%  

**Message:** The skill lacks an explicit permissions/tool-scope declaration despite relying heavily on shell execution. While shell access is required for system provisioning, declaring it would allow the agent framework to enforce least-privilege policies. Without it, the agent may execute arbitrary shell commands without restriction, increasing attack surface if the skill content is tampered with.

**Remediation:** Add a permissions block to the skill frontmatter that explicitly lists shell execution as the required capability, e.g., `permissions: [shell]`, and restrict other tools if not needed.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:181`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:182`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:192`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:193`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `SKILL.md:213`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/check_battlemage_prerequisites.sh:115`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/check_battlemage_prerequisites.sh:198`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/check_battlemage_prerequisites.sh:211`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/check_battlemage_prerequisites.sh:249`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/check_battlemage_prerequisites.sh:339`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/check_battlemage_prerequisites.sh:340`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/check_battlemage_prerequisites.sh:356`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/check_battlemage_prerequisites.sh:357`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:162`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:163`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:175`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:290`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:351`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:440`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:511`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:570`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:615`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:649`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:656`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:686`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:736`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: PE2

**Location:** `scripts/setup_xpu_system.sh:759`  
**Confidence:** 70%  

**Message:** Sudo/Root Execution

**Remediation:** Avoid sudo/root unless strictly required. Prefer least-privilege patterns. If elevation is needed, document the justification and scope.

---

### 🟡 MEDIUM: EA2

**Location:** `scripts/setup_xpu_system.sh:33`  
**Confidence:** 80%  

**Message:** Autonomous Decision Making

**Remediation:** Add human-in-the-loop confirmation for destructive, irreversible, or high-impact operations. Never auto-execute commands that modify files, send data, or alter system state.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/setup_xpu_system.sh:726`  
**Confidence:** 80%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

### 🟡 MEDIUM: RA2

**Location:** `scripts/setup_xpu_system.sh:737`  
**Confidence:** 80%  

**Message:** Session Persistence

**Remediation:** Remove any persistence mechanisms (cron jobs, startup scripts, state files). Skills should not maintain state across sessions without explicit user consent.

---

## Inspection Completeness

| Metric | Value |
|--------|-------|
| Execution | successful |
| Status | partial |
| Coverage | 33.3% |
| Fully inspected | 1 |
| Partially inspected | 2 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| reference_unresolved | `SKILL.md:3-3` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:8-8` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:16-16` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:23-23` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:25-25` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:53-53` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:68-68` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:71-71` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:79-79` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:82-82` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:85-85` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:88-88` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:91-91` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:94-94` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:98-98` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:109-109` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:156-156` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:160-160` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:198-198` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:202-202` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:216-216` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:278-278` | A local path-like reference could not be resolved unambiguously. |
| static_parse_limit | `scripts/check_battlemage_prerequisites.sh` | A security-relevant expression exceeded a bounded static parser's span limit. |
| static_parse_limit | `scripts/setup_xpu_system.sh` | A security-relevant expression exceeded a bounded static parser's span limit. |

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