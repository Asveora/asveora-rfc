## 1. Purpose

This document defines the **Privacy and Obfuscation Rules (POR)** governing how identity-related data is transformed to prevent direct or indirect identification, inference, or reconstruction across all Asveora system layers.

Privacy and obfuscation operate as a **post-minimization protective transformation layer** applied before external emission or indexing.

This specification governs:

> How identity representations are obscured, generalized, or structurally distorted to prevent identity leakage while preserving system correctness.



## 2. Core Principle

Privacy is not removal of data — it is **controlled irreversibility of identity meaning**.

Therefore:

> Identity representations must remain operationally valid while becoming non-reconstructable beyond their allowed exposure state.

Key constraint:

> Obfuscation MUST preserve functional correctness while eliminating identity reversibility.



## 3. Obfuscation Model

Obfuscation is applied after minimization (05-12) and before emission or indexing.

```text id="por_model"
CIR → APC → AUID → EDS → MINIMIZATION → OBFUSCATION → API / INDEX
```

Obfuscation is a **transformative constraint layer**, not an evaluation layer.



## 4. Obfuscation Objectives

The system enforces three primary objectives:

### 4.1 Non-Reversibility

* Obfuscated data MUST NOT allow reconstruction of original identity components
* No deterministic reversal paths permitted



### 4.2 Structural Validity

* Obfuscated outputs MUST remain syntactically valid within their schema
* AUID structure MAY remain recognizable but not fully resolvable



### 4.3 Inference Resistance

* Outputs MUST resist probabilistic or cross-context identity inference
* Correlation across federated or indexed systems MUST be limited



## 5. Obfuscation Techniques

The system supports four canonical obfuscation modes:

```text id="por_modes"
MASKING
TOKENIZATION
GENERALIZATION
NOISE_INJECTION
```



## 6. Technique Definitions

### 6.1 MASKING

Definition:

> Partial suppression of identity components while preserving structure.

Example:

```text id="mask_ex"
[APA]=[PIK]-****
```

Properties:

* Structural integrity preserved
* Sensitive fields hidden
* No direct reversibility

Constraint:

> Masking MUST NOT allow inference of hidden values.



### 6.2 TOKENIZATION

Definition:

> Replacement of identity components with deterministic surrogate values.

Properties:

* No direct identity exposure
* Stable mapping within schema version
* No structural leakage

Constraint:

> Token MUST NOT encode CIR, APC, or PIK/VSIG semantics.



### 6.3 GENERALIZATION

Definition:

> Replacement of specific identity attributes with broader categorical representations.

Example:

```text id="gen_ex"
[APA]=region-* 
```

Properties:

* Reduces granularity of identity
* Preserves categorical correctness
* Prevents exact matching

Constraint:

> Generalization MUST remove uniqueness sufficient for re-identification.



### 6.4 NOISE INJECTION

Definition:

> Introduction of controlled, schema-valid distortion into identity representation.

Properties:

* Prevents deterministic pattern matching
* Maintains syntactic validity
* Introduces controlled ambiguity

Constraint:

> Noise MUST NOT affect evaluation correctness or system determinism.



## 7. Layered Obfuscation Application

Obfuscation applies differently across identity layers:

### 7.1 CIR Layer

* CIR is never obfuscated directly (it is never exposed)
* Only derived outputs are subject to obfuscation



### 7.2 APC Layer

* PIK and VSIG are primary obfuscation targets
* VSIG MUST always be fully protected under masking or tokenization
* Partial exposure must never be reversible



### 7.3 AUID Layer

* APA MAY be generalized
* APC MUST be fully consistent with obfuscation constraints
* Structural integrity `[APA]=[PIK]-[VSIG]` must be preserved unless suppressed



### 7.4 API Layer

* Only emits obfuscated EDS outputs
* No raw or minimally transformed identity data permitted



### 7.5 Index Layer

* Stores only obfuscated representations
* No reversible identity graph construction permitted



## 8. Obfuscation Priority Rules

When multiple obfuscation methods apply, priority is enforced:

```text id="por_priority"
SUPPRESSION > TOKENIZATION > MASKING > GENERALIZATION > NOISE_INJECTION
```

Constraint:

> Higher priority method overrides all lower transformations.



## 9. Privacy Enforcement Rules

### 9.1 No Reversibility Rule

Obfuscated outputs MUST NOT support reconstruction of:

* CIR
* APC
* PIK
* VSIG



### 9.2 No Cross-System Correlation Rule

Obfuscated identity fragments MUST NOT allow:

* federation-level identity linking
* index-level correlation attacks
* API-level reconstruction inference



### 9.3 No Identity Amplification Rule

Repeated exposure of obfuscated data MUST NOT increase resolution fidelity.



## 10. Deterministic Obfuscation Function

```text id="por_fn"
ObfuscatedState =
f(MinimizedIdentity, ExposureState, FederationState, SchemaConstraints)
```

Constraints:

* MUST be deterministic
* MUST be schema-version locked
* MUST preserve structural validity without enabling identity recovery



## 11. Failure Model

### 11.1 Over-Exposure Detection

If obfuscation fails to sufficiently reduce identity risk:

* MUST escalate to SUPPRESSED state



### 11.2 Structural Integrity Failure

If obfuscation breaks schema validity:

* MUST revert to TOKENIZED or SUPPRESSED state



### 11.3 Inference Risk Detection

If cross-system correlation risk is detected:

* MUST increase obfuscation level or suppress output



## 12. Security Constraints

Privacy and obfuscation form a **protective transformation boundary layer**, therefore:

* No obfuscation method may preserve reversibility
* No combination of outputs may reconstruct identity state
* No federated or indexed system may bypass obfuscation rules
* No API output may expose pre-obfuscation structure

Security principle:

> Identity must remain useful without remaining knowable.



## 13. System Invariants

The following MUST always hold:

* Obfuscation never precedes minimization (05-12)
* CIR remains non-observable under all conditions
* SUPPRESSED overrides all obfuscation modes
* VSIG is never exposed in reversible form
* No identity reconstruction is possible through repeated observation
