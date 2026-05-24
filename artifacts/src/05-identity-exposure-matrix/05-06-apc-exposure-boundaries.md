## 1. Purpose

This document defines the **APC Exposure Constraint Model**, governing how the **Asveora Profile Core (APC)** is handled within the Identity Exposure Matrix (IEM).

APC is a **core identity component**, not a policy engine.

This specification defines:

> How APC may be exposed, transformed, masked, or suppressed while preserving integrity of its internal structure.



## 2. Core Definition

APC is defined as:

```text
APC = PIK - VSIG
```

Where:

* **PIK (Primary Identity Key)** = stable identity anchor
* **VSIG (Verification Signature)** = integrity validation component



## 3. Core Principle

APC is a **structural identity binding unit**.

Therefore:

> APC exposure must preserve internal component semantics or fully suppress the structure.

APC is never interpreted as a boundary or policy system.

It is strictly a **data-level identity construct**.



## 4. APC Exposure States

APC exposure is defined by four deterministic states:

```text
FULLY_EXPOSED
PARTIALLY_OBSCURED
TOKENIZED
SUPPRESSED
```



## 5. State Definitions

### 5.1 FULLY_EXPOSED

Definition:

> Both PIK and VSIG are emitted in canonical form.

Representation:

```text
[PIK]-[VSIG]
```

Properties:

* No transformation applied
* Full identity binding visible

Constraint:

* Only permitted under VISIBLE IVL with full authorization alignment



### 5.2 PARTIALLY_OBSCURED

Definition:

> One or more APC components are masked while preserving structural form.

Properties:

* Structure `[PIK]-[VSIG]` remains intact
* Either PIK or VSIG may be redacted
* Structural position MUST be preserved

Examples:

* `[PIK]-****`
* `****-[VSIG]`

Constraint:

> Must not allow reconstruction of masked component.



### 5.3 TOKENIZED

Definition:

> APC is replaced with a deterministic surrogate identifier.

Properties:

* No direct exposure of PIK or VSIG
* Token preserves referential consistency within evaluation scope
* May support controlled rehydration under authorization

Constraint:

* Tokenization MUST be schema-versioned and deterministic



### 5.4 SUPPRESSED

Definition:

> APC is fully removed from all outputs.

Properties:

* No representation emitted
* No indexing participation
* No structural placeholders unless schema explicitly requires them

Constraint:

* Terminal state for DENIED IVL or invalid verification state



## 6. Component Sensitivity Model

| Component | Sensitivity               |
|  | - |
| PIK       | High                      |
| VSIG      | High (integrity-critical) |

Rules:

* VSIG must never be independently exposed in verifiable form
* PIK must not be derivable from partial outputs
* Partial exposure must not enable recombination inference



## 7. IVL Mapping to APC Exposure

| IVL State   | APC Exposure State                 |
| -- | - |
| VISIBLE     | FULLY_EXPOSED / PARTIALLY_OBSCURED |
| CONDITIONAL | PARTIALLY_OBSCURED                 |
| RESTRICTED  | TOKENIZED                          |
| DENIED      | SUPPRESSED                         |



## 8. AUID Dependency Constraint

APC directly constrains AUID (05-05):

* If APC = SUPPRESSED → AUID = SUPPRESSED
* If APC = TOKENIZED → AUID MUST NOT exceed TOKENIZED state
* If VSIG is invalid → APC = SUPPRESSED → AUID = SUPPRESSED

Constraint:

> AUID exposure cannot exceed APC permissibility.



## 9. Indexing Interaction Rules

From 05-04 Public Indexing Rules:

| APC State          | Index State         |
|  | - |
| FULLY_EXPOSED      | INDEXABLE           |
| PARTIALLY_OBSCURED | PARTIALLY_INDEXABLE |
| TOKENIZED          | PARTIALLY_INDEXABLE |
| SUPPRESSED         | NON_INDEXABLE       |

Constraint:

> SUPPRESSED overrides all indexing eligibility.



## 10. Evaluation Pipeline Placement

APC exposure evaluation occurs AFTER IVL and indexing evaluation:

```text
Stage 4  → IVL Evaluation  
Stage 4.5 → Public Indexing Rules  
Stage 4.6 → AUID Exposure Policy  
Stage 4.7 → APC Exposure Constraint Model (this spec)  
Stage 5  → Cross-Domain Resolution  
Stage 6  → Exposure Decision Set Assembly
```



## 11. Deterministic Evaluation Function

```text
APC_State =
f(PIK, VSIG, IVL, AuthorizationContext, SchemaLockedContext)
```

Constraints:

* MUST be deterministic
* MUST be schema-version locked
* MUST not depend on runtime external systems



## 12. Transformation Rules

### 12.1 PARTIAL OBSCURATION RULES

* Must preserve `[PIK]-[VSIG]` structure
* Must mask at least one component fully or partially
* Must not allow reconstruction of masked component



### 12.2 TOKENIZATION RULES

* Must replace APC with surrogate identifier
* Must preserve referential consistency within scope
* Must prevent reverse derivation of PIK or VSIG



### 12.3 SUPPRESSION RULES

* Complete omission required
* No placeholder leakage permitted
* No structural inference allowed



## 13. Failure Model

### 13.1 Invalid APC Structure

If PIK or VSIG malformed:

* MUST default to SUPPRESSED

### 13.2 Signature Verification Failure

If VSIG fails validation:

* MUST default to SUPPRESSED

### 13.3 Schema Conflict

If transformation schema mismatch occurs:

* MUST default to SUPPRESSED

All failures are **fail-closed**.



## 14. Security Constraints

APC is a **core identity binding unit**, therefore:

* No partial reconstruction of VSIG is permitted
* No inference chain may reconstruct full APC unless FULLY_EXPOSED
* Tokenization must prevent cross-context correlation
* Partial outputs must not enable identity recombination

Security principle:

> APC exposure must never enable identity reconstruction beyond authorized IVL bounds.



## 15. System Invariants

The following MUST always hold:

* SUPPRESSED overrides all states
* VSIG integrity is non-bypassable
* APC structure MUST remain consistent when partially exposed
* Tokenization MUST be deterministic and non-reversible
* No state may enable reconstruction unless FULLY_EXPOSED
