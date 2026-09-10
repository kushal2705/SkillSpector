# SkillSpector Security Report

**Skill:** local-ai-app-integration  
**Source:** `/Users/kmittal/Code/GTM/amd-skills/skills/local-ai-app-integration`  
**Scanned:** 2026-09-04 20:17:40 UTC  

## Risk Assessment

| Metric | Value |
|--------|-------|
| Score | 100/100 |
| Severity | CRITICAL |
| Recommendation | DO NOT INSTALL |

## Components (6)

| File | Type | Lines | Executable |
|------|------|-------|------------|
| `SKILL.md` | markdown | 471 | No |
| `evals/evals.json` | json | 73 | No |
| `evals/files/apikey-guard/main.py` | python | 9 | Yes |
| `evals/files/openai-stub/main.py` | python | 3 | Yes |
| `reference.md` | markdown | 382 | No |
| `skill-card.md` | markdown | 13 | No |

## Issues (8)

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 95%  

**Message:** Description-behavior mismatch: declared purpose is 'Integrates local AI using Embeddable Lemonade for offline/private AI, replacing cloud APIs in user apps.' but code also performs: Uses cloud-based OpenAI API instead of local AI via Embeddable Lemonade, Does not perform any app conversion or integration with Lemonade, No local AI, embeddings, image generation, speech-to-text, or text-to-speech functionality.

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `Loads an OpenAI API key from environment variables and creates an OpenAI client for cloud API usage.`
- **code_end_line:** `9`
- **code_path:** `evals/files/apikey-guard/main.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: TP4

**Location:** `SKILL.md:1`  
**Confidence:** 100%  

**Message:** Description-behavior mismatch: declared purpose is 'Integrates local AI capabilities using Embeddable Lemonade, supports local LLM, chat, embeddings, image generation, speech, etc.' but code also performs: Local AI integration, Embeddable Lemonade usage, All specified AI features (chat, embeddings, image gen, speech).

**Remediation:** Update the skill description to accurately reflect all capabilities, or remove undeclared functionality from the implementation.

**Evidence:**
- **actual_behavior_summary:** `Imports OpenAI and creates a client instance, which is a stub for cloud API access, not local AI.`
- **code_end_line:** `3`
- **code_path:** `evals/files/openai-stub/main.py`
- **code_start_line:** `1`

---

### 🔴 HIGH: SDI-1

**Location:** `evals/files/apikey-guard/main.py:5–9`  
**Confidence:** 100%  

**Message:** The skill metadata explicitly promises local, offline, private, on-device AI using Embeddable Lemonade. However, the code imports the `openai` SDK and creates an OpenAI client using `OPENAI_API_KEY`. This is the opposite of local AI: any subsequent use of this client will send data to OpenAI’s cloud API, breaking the core privacy/offline guarantee. Even though this snippet only creates a client and does not show a network call, the presence of the OpenAI client is a strong indicator that the integration is designed to use a cloud backend. This is especially dangerous because users would invoke this skill expecting their data to remain on-device, while it may be transmitted to a third-party cloud service.

**Remediation:** Remove the `openai` SDK and `OPENAI_API_KEY` usage entirely. Replace the client with the local Embeddable Lemonade runtime and use its local inference/embedding endpoints. Add a network policy that blocks outbound connections to cloud APIs unless explicitly and transparently allowed. Audit all skill code for hidden cloud calls.

---

### 🔴 HIGH: SDI-1

**Location:** `evals/files/openai-stub/main.py:1–3`  
**Confidence:** 95%  

**Message:** The skill description promises local, offline, private AI integration via Embeddable Lemonade, but the code simply imports and instantiates an OpenAI client, which routes requests to the OpenAI cloud. If this code is used as the integration stub in a skill designed to convert user apps to local AI, the resulting app would still depend on a remote API, leaking sensitive data and violating offline/privacy requirements. This is a classic description-behavior mismatch that can deceive users or downstream consumers.

**Remediation:** Replace the OpenAI import/instantiation with the actual Embeddable Lemonade API (e.g., `from embeddable_lemmonade import ...`). Ensure the stub reflects the intended local backend, and add tests to verify that no cloud API client is used. Also review the skill’s manifest to ensure it does not reference OpenAI or other cloud services unless explicitly permitted.

---

### 🟡 MEDIUM: LP3

**Location:** `SKILL.md:1`  
**Confidence:** 70%  

**Message:** Skill declares no tool scope ('permissions' or 'allowed-tools') but code capabilities were detected: env.

**Remediation:** Declare the skill's tool scope: for Claude Code / Agent Skills SKILL.md, list the tools the skill may invoke in the 'allowed-tools' frontmatter field; for MCP server manifests, add a 'permissions' list naming the required capabilities.

---

### 🟡 MEDIUM: E1

**Location:** `SKILL.md:156`  
**Confidence:** 70%  

**Message:** The skill instructs the agent to download an executable binary (the Embeddable Lemonade package) from a GitHub release, then run it as a subprocess. The download URL is derived from the GitHub API, and no integrity verification (checksum, signature) is mentioned. This is a supply-chain risk: if the GitHub repository or release is compromised, the downloaded binary could contain malicious code that runs on the user's machine. The skill also instructs to install backends and pull models, all of which involve downloading and executing code from the internet. While the intent is clearly to fetch the official Lemonade SDK, the lack of integrity checks makes the skill vulnerable to man-in-the-middle or supply-chain attacks. The impact is high because arbitrary code execution is possible.

**Remediation:** Add explicit steps to verify the integrity of the downloaded archive using a published SHA-256 checksum or a GPG signature. Instruct the agent to compare the hash against a known good value from the official repository (e.g., in the release notes or a separate trusted source). Additionally, recommend pinning to a specific version tag rather than always fetching the latest release to reduce the risk of unexpected changes.

---

### 🟡 MEDIUM: E1

**Location:** `SKILL.md:169`  
**Confidence:** 70%  

**Message:** This is the Linux variant of the same external transmission issue: the skill uses `curl` to fetch the latest release tarball from GitHub and unpacks it without integrity verification. The risk is identical to finding 4: the downloaded binary is executed as part of the integration, so any compromise of the download source leads to arbitrary code execution. The intent is benign, but the lack of checksum verification exposes the user to supply-chain attacks.

**Remediation:** Same as finding 4: enforce checksum verification before extraction, prefer pinning to a specific release, and consider using a package manager with built-in integrity checks if available. Also recommend using HTTPS and validating the TLS certificate chain (which `curl` does by default) as a baseline.

---

### 🟡 MEDIUM: SDI-2

**Location:** `evals/files/apikey-guard/main.py:5–9`  
**Confidence:** 90%  

**Message:** The code reads the `OPENAI_API_KEY` environment variable and passes it to an OpenAI client. This capability is completely unjustified by the stated purpose of local AI integration. Reading a cloud API key can enable two serious attacks: (1) the key may be exfiltrated by later malicious code in the skill, allowing unauthorized use and financial abuse; (2) the key may be used to make cloud API calls that leak user data out of the supposedly local environment. Even if this is only leftover code from a previous cloud-based implementation, it creates a privacy and security risk in a skill that claims to be offline and private.

**Remediation:** Do not access `OPENAI_API_KEY` or any cloud service credentials in a local AI skill. Remove the environment variable read and the OpenAI client initialization. If credentials are truly needed, require explicit user consent and clearly disclose the cloud dependency. For local AI, use a local tokenizer/model loader that does not require any API key.

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
| reference_unresolved | `SKILL.md:19-19` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:68-68` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:69-69` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:70-70` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:76-76` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:99-99` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:100-100` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:115-115` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:136-136` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:150-150` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:171-171` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:182-182` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:204-204` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:209-209` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:223-223` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:233-233` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:234-234` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:251-251` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:327-327` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:410-410` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:445-445` | A local path-like reference could not be resolved unambiguously. |
| reference_unresolved | `SKILL.md:470-470` | A local path-like reference could not be resolved unambiguously. |

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