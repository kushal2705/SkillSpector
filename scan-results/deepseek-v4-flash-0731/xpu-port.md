# SkillSpector Security Report

**Skill:** xpu-port  
**Source:** `/Users/kmittal/Code/GTM/gpu-ai-skills/plugins/intel-gpu-ai-skills/skills/xpu-port`  
**Scanned:** 2026-09-02 06:48:35 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 100/100 |
| Severity | CRITICAL |
| Recommendation | DO NOT INSTALL |

## Components (6)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 231 | No |
| `references/cuda_to_xpu_whitelist.md` | markdown | 38 | No |
| `references/semantic-patterns.md` | markdown | 115 | No |
| `scripts/xpu_port_rewrite.py` | python | 639 | Yes |
| `scripts/xpu_port_scan.py` | python | 1098 | Yes |
| `scripts/xpu_port_verify.py` | python | 297 | Yes |

## Issues (11)

### 🔴 CRITICAL: AST8

**Location:** `scripts/xpu_port_verify.py:74`  
**Confidence:** 95%  

**Message:** Dangerous chain: exec() wrapping compile

**Remediation:** Remove the execution chain entirely. Never pass network data, decoded bytes, or dynamically imported code to exec()/eval(). Use structured data formats instead.

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 95%  

**Message:** Description-behavior mismatch: declared purpose is 'Full CUDA-to-XPU port pipeline: libcst-based scan, mechanical rewrite, and CPU FP64 vs target-dtype verification on one forward pass.' but code also performs: Scanning for CUDA usage, CPU FP64 vs target-dtype correctness verification, Executing a forward pass.

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `Standalone script applying one of seven mechanical libcst rewrite transforms (device strings, torch.cuda → torch.xpu, .cuda() → .xpu(), imports, NCCL→XCCL, AMP autocast/GradScaler). No scanning, no verification, no forward pass execution.`
- **code_end_line:** `639`
- **code_path:** `scripts/xpu_port_rewrite.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 95%  

**Message:** Description-behavior mismatch: declared purpose is 'Executes a full CUDA-to-XPU port including libcst-based scan, mechanical rewrite, and CPU FP64 vs target-dtype correctness verification on one forward pass.' but code also performs: Mechanical rewrite of code, CPU FP64 vs target-dtype correctness verification.

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `This code is a read-only scanner that analyzes Python source for CUDA-related call sites using libcst, classifies findings into buckets (mechanical/semantic/escalate), and emits JSON. It does not perform any rewrite or correctness verification. It also includes an infra-marker probe for empty-scan routing hints.`
- **code_end_line:** `1098`
- **code_path:** `scripts/xpu_port_scan.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 100%  

**Message:** Description-behavior mismatch: declared purpose is 'Performs a full CUDA-to-XPU port including libcst-based scan, mechanical rewrite, and correctness verification.' but code also performs: libcst-based scan, mechanical rewrite.

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `A standalone verification script that compares a model's CPU FP64 output against a target-device/target-dtype output for a single forward pass. Does not perform any source scanning or rewriting.`
- **code_end_line:** `297`
- **code_path:** `scripts/xpu_port_verify.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: AST1

**Location:** `scripts/xpu_port_verify.py:74`  
**Confidence:** 85%  

**Message:** exec() call detected

**Remediation:** Replace exec() with a safe alternative. If dynamic execution is required, use a sandboxed environment or restricted eval with __builtins__ disabled.

---

### 🟡 MEDIUM: LP3

**Location:** `SKILL.md:1`  
**Confidence:** 70%  

**Message:** The skill metadata does not declare any `permissions` or `allowed-tools`, despite the procedure requiring environment variable manipulation (`PYTORCH_ENABLE_XPU_FALLBACK=0`) and file reads/writes through the helper scripts. An agent using this skill would fall back to whatever default tool permissions are configured, potentially granting broader filesystem/environment access than necessary. This violates the principle of least privilege and increases the attack surface if any script or instruction is maliciously tampered with.

**Remediation:** Add explicit `permissions` or `allowed-tools` fields to the skill metadata listing exactly what is needed (e.g., `file_read`, `file_write`, `env`), and constrain paths to the target repository where possible.

---

### 🟡 MEDIUM: SQP-2

**Location:** `SKILL.md:99–105`  
**Confidence:** 75%  

**Message:** The skill performs in-place source code modifications through the mechanical rewrite loop (`xpu_port_rewrite.py --transform ... --path .`) and subsequent hand-edits, but neither the description nor the procedure warns users to back up their work or ensure version control. An erroneous transform or unexpected edge case could silently corrupt source files. While the user did request a port, the destructive nature of the operation should be explicitly surfaced to allow informed consent and rollback.

**Remediation:** Add a prominent warning near the top of the skill and in the Procedure section: 'This skill modifies Python source files in-place. Ensure your repository has a clean git working tree or create a backup before running the mechanical pass.' Additionally, suggest using `--check` first to preview diffs, which the skill already mentions but could emphasize.

---

### 🟡 MEDIUM: RP1

**Location:** `scripts/xpu_port_scan.py:770`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus`;'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: RP1

**Location:** `scripts/xpu_port_scan.py:795`  
**Confidence:** 75%  

**Message:** Docker image referenced without tag or digest: 'docker run --gpus'.

**Remediation:** Pin the image: image:tag or image@sha256:abc123

---

### 🟡 MEDIUM: AST6

**Location:** `scripts/xpu_port_verify.py:74`  
**Confidence:** 65%  

**Message:** compile() call detected

**Remediation:** Avoid compile() with dynamic strings. If code generation is needed, use templates or AST manipulation with strict validation.

---

### 🟢 LOW: AST7

**Location:** `scripts/xpu_port_verify.py:200`  
**Confidence:** 50%  

**Message:** Dynamic attribute access via getattr()

**Remediation:** Replace dynamic getattr() with explicit attribute access or a dictionary lookup with an allowlist of permitted attributes.

---

## Inspection Completeness

| Metric | Value |
|--------|-------|
| Execution | successful |
| Status | partial |
| Coverage | 100.0% |
| Fully inspected | 6 |
| Partially inspected | 0 |
| Entirely uninspected | 0 |

### Ledger Exceptions

| Reason / Status | Location | Details |
|-----------------|----------|---------|
| reference_unresolved | `SKILL.md:12-12` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:43-43` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:59-59` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:67-67` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:85-85` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:87-87` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:88-88` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:103-103` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:115-115` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:139-139` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:167-167` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:198-198` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:230-230` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:231-231` | A local path-like reference could not be resolved unambiguously. |

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
| completed | `` |  |

## Metadata

- **Executable Scripts:** Yes

*Generated by SkillSpector v2.11.0*