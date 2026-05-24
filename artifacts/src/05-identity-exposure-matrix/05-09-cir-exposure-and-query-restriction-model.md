## 1. Purpose

This document defines the **CIR Exposure and Query Restriction Model (CERM)** governing how the **CIR (Core Identity Record)** may be exposed, queried, filtered, or suppressed within the Identity Exposure Matrix (IEM).

CIR is the **root identity truth layer** of the Asveora system.

This specification governs:

> How CIR may be accessed indirectly via query systems, and how exposure of CIR-derived identity material is restricted across all downstream layers.



## 2. Core Principle

CIR is **not an exposed identity object by default**.

Therefore:

> CIR MUST NEVER be directly emitted through any API, federation layer, or identity descriptor system (AUID/APC), except under explicitly authorized evaluation conditions.

Key constraint:

> CIR is a query-resolved truth source, not a representation layer.



## 3. CIR Model Definition

CIR is defined as:

```text id="cir_def"
CIR = Core Identity Record
```

CIR is the **atomic truth state** from which all identity constructs are derived:

* APA (address layer)
* APC (identity core)
* AUID (descriptor layer)

Constraint:

> CIR is never stored or emitted as a composite identity structure.



## 4. CIR Exposure Model

CIR exposure is defined by a strict suppression-first model:

```text id="cir_exposure_model"
UNRESOLVED
DERIVED
INDIRECT
SUPPRESSED
```



## 5. State Definitions

### 5.1 UNRESOLVED

Definition:

> CIR exists but cannot be resolved due to missing evaluation context.

Properties:

* No identity derivation possible
* No mapping to APA/APC/AUID
* Query returns null-resolution state

Constraint:

> No fallback inference permitted.



### 5.2 DERIVED

Definition:

> CIR is used internally to derive identity components without exposure.

Properties:

* Used to compute APA, PIK, VSIG
* Never exposed directly
* Exists only in evaluation memory context

Constraint:

> DERIVED CIR MUST NOT be externally observable.



### 5.3 INDIRECT

Definition:

> CIR influences exposed identity structures without being directly accessible.

Properties:

* Appears only through AUID/APC outputs
* No CIR reconstruction possible from outputs
* All references are lossy projections

Constraint:

> CIR cannot be reverse-engineered from INDIRECT outputs.



### 5.4 SUPPRESSED

Definition:

> CIR is fully inaccessible across all layers.

Properties:

* No query resolution possible
* No derivation permitted
* No downstream identity generation allowed

Constraint:

> Terminal state across all identity systems.



## 6. CIR Query Restriction Model

CIR access is governed by a **query gating system**:

### 6.1 Query Categories

```text id="cir_query_types"
IDENTITY_LOOKUP
DERIVATION_QUERY
FEDERATION_QUERY
SYSTEM_INTERNAL_QUERY
```



### 6.2 Query Rules

#### 6.2.1 IDENTITY_LOOKUP

* Must resolve only AUID-level outputs
* CIR is never returned
* Returns DERIVED or INDIRECT state only



#### 6.2.2 DERIVATION_QUERY

* Used internally to compute APC/AUID
* CIR remains non-exposed
* Must be evaluation-scoped only



#### 6.2.3 FEDERATION_QUERY

* CIR is never transmitted across nodes
* Only federated descriptors are exchanged (AUID/APC)
* CIR remains local-only truth source



#### 6.2.4 SYSTEM_INTERNAL_QUERY

* Only valid within evaluation engine
* CIR may be accessed in DERIVED form only
* Must never escape evaluation boundary



## 7. CIR Exposure Constraints

CIR exposure is strictly constrained:

* CIR MUST NOT appear in API responses
* CIR MUST NOT be reconstructable from AUID/APC/PIK/VSIG
* CIR MUST NOT be inferred through federation aggregation
* CIR MUST NOT be exposed in partial or hashed form

Key rule:

> CIR is always one level deeper than any observable identity construct.



## 8. Relationship to Identity Stack

CIR sits at the base of the identity hierarchy:

```text id="cir_stack"
CIR → APA → APC → AUID
```

Flow rules:

* CIR produces APA/APC
* APA/APC produce AUID
* AUID is the only externally valid descriptor

Constraint:

> No upward reconstruction from AUID to CIR is permitted under any state.



## 9. IVL Interaction Model

CIR does not directly participate in IVL evaluation.

Instead:

| IVL State   | CIR Behavior       |
| -- |  |
| VISIBLE     | DERIVED / INDIRECT |
| CONDITIONAL | DERIVED            |
| RESTRICTED  | INDIRECT           |
| DENIED      | SUPPRESSED         |

Constraint:

> IVL applies only to derived representations, never CIR itself.



## 10. APC / AUID Dependency Constraint

From prior sections:

* APC depends on CIR-derived PIK and VSIG
* AUID depends on APC and APA

Therefore:

* CIR suppression → APC invalidation → AUID suppression
* CIR instability → full identity cascade suppression

Rule:

> CIR failure propagates downward, never upward.



## 11. Deterministic Evaluation Function

```text id="cir_fn"
CIR_State =
f(QueryContext, AuthorizationContext, SchemaConstraints, EvaluationLayer)
```

Constraints:

* MUST be deterministic
* MUST be schema-version locked
* MUST never expose CIR directly



## 12. Failure Model

### 12.1 CIR Resolution Failure

If CIR cannot be resolved:

* MUST return UNRESOLVED
* MUST prevent all downstream derivations



### 12.2 Authorization Failure

If CIR access is unauthorized:

* MUST return SUPPRESSED
* MUST block all dependent identity generation



### 12.3 Schema Conflict

If CIR schema mismatch occurs:

* MUST default to SUPPRESSED state



## 13. Security Constraints

CIR is the **root identity truth layer**, therefore:

* CIR must never be exposed in raw form
* CIR must never be reconstructed from derived outputs
* CIR must never cross federation boundaries
* CIR must remain non-reversible by design

Security principle:

> CIR is not an identity endpoint — it is an identity origin that cannot be traversed.



## 14. System Invariants

The following MUST always hold:

* CIR is never externally visible
* All identity constructs are CIR-derived, not CIR-reconstructable
* SUPPRESSED CIR halts entire identity pipeline
* DERIVED CIR is strictly internal-only
* No query path permits CIR rehydration
