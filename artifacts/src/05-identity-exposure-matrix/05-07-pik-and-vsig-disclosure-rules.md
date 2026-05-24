## 1. Purpose

This document defines the **disclosure rules for PIK (Primary Identity Key) and VSIG (Verification Signature)** within the Identity Exposure Matrix (IEM).

PIK and VSIG are **atomic components of APC (Asveora Profile Core)** and therefore represent the most sensitive identity-bound elements in the system.

This specification governs:

> When PIK and VSIG may be individually exposed, jointly exposed, transformed, or suppressed under evaluated identity visibility conditions.



## 2. Core Principle

PIK and VSIG are **non-independent disclosure elements** in normal operation.

Therefore:

> Neither PIK nor VSIG may be disclosed in isolation unless explicitly permitted by evaluated IVL, APC state, and authorization context.

Key constraint:

> VSIG integrity is always prioritized over representational convenience.



## 3. Component Definitions

### 3.1 PIK (Primary Identity Key)

* Stable identity anchor within APC
* Used for identity resolution across systems
* May enable cross-context identity correlation if exposed

### 3.2 VSIG (Verification Signature)

* Cryptographic or schema-validated integrity component
* Proves authenticity and validity of APC binding
* Exposure risk includes verification replay or integrity inference



## 4. Disclosure Model Overview

PIK and VSIG disclosure is governed by a deterministic model:

```text id="pikvsig_model"
D(P, V) = f(IVL, APC_State, AuthorizationContext, SchemaConstraints)
```

Where:

* P = PIK
* V = VSIG



## 5. Disclosure States

PIK and VSIG each independently support the following disclosure states:

```text id="pikvsig_states"
FULLY_DISCLOSED
MASKED
TOKENIZED
SUPPRESSED
```

However, **joint disclosure rules override independent state behavior**.



## 6. Joint Disclosure Rules

PIK and VSIG MUST be evaluated as a **paired integrity system** under APC:

### 6.1 FULL JOINT DISCLOSURE

Definition:

> Both PIK and VSIG are fully exposed.

Condition:

* APC_STATE = FULLY_EXPOSED
* IVL = VISIBLE
* Authorization explicitly permits full identity resolution

Representation:

```text id="joint_full"
PIK - VSIG
```

Constraint:

* Only valid when no restriction exists at any evaluation layer



### 6.2 PARTIAL JOINT DISCLOSURE

Definition:

> One component may be exposed while the other is masked.

Allowed forms:

```text id="joint_partial"
PIK - ****
**** - VSIG
```

Rules:

* Structural integrity MUST be preserved
* Masked component MUST NOT be derivable from exposed component
* No bidirectional reconstruction allowed

Constraint:

> Partial disclosure is only permitted under CONDITIONAL or RESTRICTED IVL.



### 6.3 TOKENIZED JOINT DISCLOSURE

Definition:

> PIK and VSIG are replaced with a unified surrogate token.

Properties:

* No direct exposure of either component
* Referential consistency maintained within evaluation scope
* No structural leakage permitted

Constraint:

* Must be schema-version deterministic



### 6.4 SUPPRESSED DISCLOSURE

Definition:

> Neither PIK nor VSIG is exposed in any form.

Properties:

* No representation emitted
* No indexing participation
* No structural placeholders unless explicitly defined

Constraint:

* Default for DENIED IVL or invalid APC state



## 7. Isolation Rule

PIK and VSIG MUST NEVER be independently exposed in a way that allows:

* reconstruction of APC structure
* inference of missing component
* cross-context identity correlation without authorization

Rule:

> Independent disclosure is strictly prohibited unless full joint disclosure is authorized.



## 8. IVL Mapping to Disclosure Behavior

| IVL State   | PIK/VSIG Disclosure Behavior     |
| -- | -- |
| VISIBLE     | FULL or PARTIAL JOINT DISCLOSURE |
| CONDITIONAL | PARTIAL JOINT DISCLOSURE         |
| RESTRICTED  | TOKENIZED                        |
| DENIED      | SUPPRESSED                       |



## 9. APC Dependency Constraint

PIK and VSIG disclosure MUST respect APC state (05-06):

* If APC = SUPPRESSED → PIK = SUPPRESSED, VSIG = SUPPRESSED
* If APC = TOKENIZED → PIK/VSIG MUST NOT be independently exposed
* If VSIG invalid → BOTH components MUST be SUPPRESSED

Constraint:

> APC state is the upper-bound constraint for all PIK/VSIG disclosure logic.



## 10. AUID Interaction Rule

From 05-05 (AUID Exposure Policy):

* PIK and VSIG disclosure directly affects AUID validity
* Partial disclosure MUST force AUID → SEGMENTED or lower
* SUPPRESSED PIK/VSIG → AUID MUST be SUPPRESSED



## 11. Indexing Interaction Rules

From 05-04 Public Indexing Rules:

| Disclosure State   | Index Impact        |
|  | - |
| FULL DISCLOSURE    | INDEXABLE           |
| PARTIAL DISCLOSURE | PARTIALLY_INDEXABLE |
| TOKENIZED          | PARTIALLY_INDEXABLE |
| SUPPRESSED         | NON_INDEXABLE       |

Constraint:

> Any SUPPRESSED component forces NON_INDEXABLE state.



## 12. Evaluation Pipeline Placement

PIK/VSIG disclosure occurs within APC evaluation phase:

```text id="pv_pipeline"
Stage 4  → IVL Evaluation  
Stage 4.5 → Public Indexing Rules  
Stage 4.6 → AUID Exposure Policy  
Stage 4.7 → APC Exposure Constraint Model  
Stage 4.8 → PIK/VSIG Disclosure Rules (this spec)  
Stage 5  → Cross-Domain Resolution  
Stage 6  → Exposure Decision Set Assembly
```



## 13. Deterministic Evaluation Function

```text id="pv_func"
PIK_VSIG_State =
f(PIK, VSIG, APC_State, IVL, AuthorizationContext, SchemaLockedContext)
```

Constraints:

* MUST be deterministic
* MUST be schema-version locked
* MUST not depend on runtime external systems



## 14. Transformation Rules

### 14.1 MASKING RULES

* Must preserve position in APC structure
* Must not allow inference of hidden component
* Must not allow recombination without authorization



### 14.2 TOKENIZATION RULES

* Must replace both components with single surrogate
* Must preserve referential identity within scope
* Must prevent reverse derivation of either component



### 14.3 SUPPRESSION RULES

* Complete omission required
* No placeholders allowed unless schema explicitly defines them
* No metadata leakage permitted



## 15. Failure Model

### 15.1 Invalid Component State

If PIK or VSIG malformed:

* MUST default to SUPPRESSED

### 15.2 Signature Failure

If VSIG validation fails:

* MUST suppress BOTH PIK and APC

### 15.3 Schema Conflict

If transformation schema mismatch occurs:

* MUST default to SUPPRESSED

All failures are **fail-closed**.



## 16. Security Constraints

PIK and VSIG are **core identity integrity components**, therefore:

* VSIG must never be exposed in verifiable partial form
* PIK must not enable identity graph reconstruction alone
* Partial disclosure must not allow APC reconstruction
* Tokenization must prevent cross-context identity linking

Security principle:

> Identity integrity components must never become independently exploitable.



## 17. System Invariants

The following MUST always hold:

* SUPPRESSED overrides all disclosure states
* VSIG cannot be independently validated from partial output
* PIK alone cannot reconstruct APC
* Partial disclosure cannot enable recombination inference
* Tokenization must remain deterministic and non-reversible
