## 1. Purpose

This document defines the **AUID Exposure Policy (AEP)** governing how the **Asveora Unified Identity Descriptor (AUID)** is handled within the Identity Exposure Matrix (IEM).

AUID is a **composite identity descriptor** formed from addressing and identity-core components. This policy governs how that composite structure may be exposed, transformed, indexed, or suppressed while preserving structural and semantic integrity.



## 2. Core Definition

AUID is defined as:

> **Asveora Unified Identity Descriptor**

AUID is a structured descriptor that combines identity address context with identity core binding.

### Structural Form:

```text
AUID = APA = APC
```

Where:

* **APA (Asveora Profile Address)** = identity namespace / routing context
* **APC (Asveora Profile Core)** = `[PIK]-[VSIG]`

Expanded canonical form:

```text
AUID = [APA]=[PIK]-[VSIG]
```



## 3. Core Principle

AUID is a **descriptor-layer construct over identity composition**, not a raw identity object.

Therefore:

> AUID exposure must preserve internal component boundaries (APA and APC) while ensuring no unauthorized reconstruction of identity state beyond permitted evaluation context.



## 4. Structural Decomposition Model

AUID consists of three logically distinct layers:

### 4.1 APA (Address Layer)

* Identity namespace / routing context
* Defines where identity exists within system topology

### 4.2 APC (Core Layer)

* Identity binding core
* Structured as:

  ```
  APC = PIK - VSIG
  ```
* Represents verification-bound identity anchor

### 4.3 Descriptor Layer (AUID)

* Unified wrapper combining APA + APC
* Provides a single evaluable identity reference



## 5. AUID Exposure States

AUID exposure is defined by four deterministic states:

```text
FULLY_EXPOSED
SEGMENTED
TOKENIZED
SUPPRESSED
```



## 6. State Definitions

### 6.1 FULLY_EXPOSED

Definition:

> Entire AUID is emitted in canonical form without transformation.

Representation:

```text
[APA]=[PIK]-[VSIG]
```

Properties:

* No masking applied
* Full identity resolvability enabled

Constraint:

* Permitted only under VISIBLE IVL with full authorization alignment



### 6.2 SEGMENTED

Definition:

> AUID is decomposed into independently controlled components.

Properties:

* APA, PIK, and VSIG may be independently exposed or masked
* Structural linkage is not emitted as a single unit
* Reconstruction requires all components to pass independent authorization checks

Examples:

* `[APA]=[PIK]-****`
* `[APA]=****-****`

Constraint:

> No implicit recombination of components is permitted in output layer.



### 6.3 TOKENIZED

Definition:

> AUID is replaced with a deterministic surrogate identifier.

Properties:

* No exposure of APA, PIK, or VSIG
* Token preserves referential consistency within evaluation scope
* Supports controlled rehydration if authorized

Constraint:

* Must be schema-versioned and deterministic



### 6.4 SUPPRESSED

Definition:

> AUID is fully excluded from all outputs and indexing structures.

Properties:

* No representation emitted
* No metadata leakage
* No structural placeholders unless explicitly required by schema

Constraint:

* Terminal state for DENIED IVL or incompatible APC/VSIG conditions



## 7. Component Sensitivity Model

| Component | Sensitivity Level             |
|  | -- |
| APA       | Medium (contextual routing)   |
| PIK       | High (identity anchor)        |
| VSIG      | High (verification integrity) |

Rules:

* VSIG must never be independently reconstructable
* PIK must not be derivable from APA alone
* APA must not enable identity resolution without APC validation



## 8. IVL Mapping to AUID Exposure

| IVL State   | AUID Exposure State       |
| -- | - |
| VISIBLE     | FULLY_EXPOSED / SEGMENTED |
| CONDITIONAL | SEGMENTED                 |
| RESTRICTED  | TOKENIZED                 |
| DENIED      | SUPPRESSED                |



## 9. APC Dependency Constraint

AUID exposure is dependent on APC validity:

* If APC is invalid → AUID = SUPPRESSED
* If VSIG fails verification → AUID = SUPPRESSED
* If APC is TOKENIZED or SUPPRESSED internally → AUID MUST reflect equivalent or stricter state

Constraint:

> AUID cannot exceed APC exposure permissibility.



## 10. Indexing Interaction Rules

From 05-04 Public Indexing Rules:

| AUID State    | Index State         |
| - | - |
| FULLY_EXPOSED | INDEXABLE           |
| SEGMENTED     | PARTIALLY_INDEXABLE |
| TOKENIZED     | PARTIALLY_INDEXABLE |
| SUPPRESSED    | NON_INDEXABLE       |

Constraint:

> SUPPRESSED overrides all indexing eligibility.



## 11. Evaluation Pipeline Placement

AUID exposure evaluation occurs after IVL and indexing evaluation:

```text
Stage 4  → IVL Evaluation  
Stage 4.5 → Public Indexing Rules  
Stage 4.6 → AUID Exposure Policy (this spec)  
Stage 4.7 → APC Exposure Evaluation (05-06)  
Stage 5  → Cross-Domain Resolution  
Stage 6  → Exposure Decision Set Assembly
```



## 12. Deterministic Evaluation Function

```text
AUID_State =
f(APA, PIK, VSIG, IVL, APC_State, AuthorizationContext, SchemaLockedContext)
```

Constraints:

* MUST be deterministic
* MUST be schema-version locked
* MUST not depend on runtime external systems



## 13. Transformation Rules

### 13.1 SEGMENTATION RULES

* Components may be independently masked
* Structural form may remain partially reconstructable
* No implicit recombination permitted in output

### 13.2 TOKENIZATION RULES

* Must replace full AUID with surrogate
* Must preserve referential identity within scope
* Must prevent reverse derivation

### 13.3 SUPPRESSION RULES

* Complete omission required
* No placeholder leakage permitted



## 14. Failure Model

### 14.1 Invalid Structure

If APA or APC is malformed:

* MUST default to SUPPRESSED

### 14.2 VSIG Failure

If verification signature fails:

* MUST default to SUPPRESSED

### 14.3 Schema Conflict

If transformation schema mismatch occurs:

* MUST default to SUPPRESSED

All failures are **fail-closed**.



## 15. Security Constraints

AUID is a **hierarchical identity descriptor**, therefore:

* No partial reconstruction of full AUID is permitted unless FULLY_EXPOSED
* VSIG must never be exposed independently
* PIK must not be derivable from partial outputs
* APA must not enable identity graph traversal without authorization

Security principle:

> AUID exposure must never enable identity reconstruction beyond allowed IVL boundaries.



## 16. System Invariants

The following MUST always hold:

* SUPPRESSED overrides all states
* APC constraints always dominate AUID exposure
* VSIG is never independently reconstructable
* SEGMENTED state must not enable recombination leakage
* Tokenization must remain deterministic and non-reversible
