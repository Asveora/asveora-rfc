## 1. Purpose

This document defines the **External API Exposure Layer (EAEL)**, which governs how identity constructs from the Asveora system are exposed to external consumers via APIs.

The External API Layer is the **final emission boundary** in the Identity Exposure Matrix (IEM).

This specification governs:

> What identity data (AUID, APC, PIK, VSIG-derived representations) may be emitted externally, under what transformation rules, and with what structural guarantees.



## 2. Core Principle

The External API Layer is an **emission-only boundary**, not a computation or evaluation layer.

Therefore:

> No identity resolution, derivation, or CIR access occurs at the API layer.

Key constraint:

> The API layer may only emit pre-evaluated, schema-approved representations.



## 3. API Exposure Model

All external outputs are derived from a precomputed:

```text id="api_model"
Exposure Decision Set (EDS)
```

The API layer MUST NOT:

* compute IVL
* resolve APC
* access CIR
* modify AUID structure

It ONLY:

> emits EDS-approved representations.



## 4. Allowed External Identity Constructs

The External API Layer may expose only the following constructs:

* **AUID (Asveora Unified Identity Descriptor)**
* **TOKENIZED identity references**
* **HASHED or masked representations of APC components**
* **NON-identity metadata derived from CIR indirectly**

Constraint:

> CIR, raw PIK, and raw VSIG are strictly forbidden from external emission.



## 5. External Exposure States

The API layer supports four emission states:

```text id="api_states"
FULL_EMISSION
PARTIAL_EMISSION
TOKENIZED_EMISSION
SUPPRESSED_EMISSION
```



## 6. State Definitions

### 6.1 FULL_EMISSION

Definition:

> Fully resolved AUID is emitted externally.

Representation:

```text id="full_emit"
[APA]=[PIK]-[VSIG]
```

Conditions:

* Only allowed when ALL upstream layers permit FULLY_EXPOSED state
* Must pass federation reconciliation (05-08)
* Must comply with APC + PIK/VSIG disclosure rules

Constraint:

> CIR remains strictly non-emitted even in full emission.



### 6.2 PARTIAL_EMISSION

Definition:

> AUID is emitted with masked or redacted components.

Examples:

```text id="partial_emit"
[APA]=[PIK]-****
[APA]=****-****
```

Properties:

* Structural integrity preserved
* Sensitive components redacted
* No reconstructable leakage permitted

Constraint:

> Partial emission must remain non-reversible.



### 6.3 TOKENIZED_EMISSION

Definition:

> AUID is replaced with a deterministic external token.

Properties:

* No structural identity exposed
* Token is stable across API calls (within schema version)
* Supports external referencing without identity leakage

Constraint:

> Token MUST NOT encode PIK, VSIG, or CIR-derived data.



### 6.4 SUPPRESSED_EMISSION

Definition:

> No identity data is emitted.

Properties:

* API returns null or suppression response
* No metadata leakage allowed
* No structural placeholders unless schema defines them

Constraint:

* Default state for DENIED or FAILED evaluation chains



## 7. API Layer Constraints

### 7.1 Emission-Only Rule

The API layer MUST NOT:

* perform identity evaluation
* modify exposure states
* resolve AUID/APC/CIR
* reconstruct missing identity components



### 7.2 Pre-Evaluated Input Rule

All API responses MUST originate from:

```text id="eds_source"
Exposure Decision Set (EDS)
```

Constraint:

> API is a renderer, not an evaluator.



### 7.3 No CIR Exposure Rule

CIR is strictly forbidden from external emission:

* CIR must never appear in API payloads
* CIR-derived inference must remain indirect only
* CIR reconstruction from API outputs is prohibited by design



## 8. Interaction with Identity Stack

The API layer sits above the identity system:

```text id="api_stack"
CIR → APA → APC → AUID → EDS → API
```

Rules:

* API only consumes EDS
* EDS is the only valid input boundary
* No upward traversal permitted



## 9. Federation Constraint Alignment

From 05-08:

* API MUST respect FEDERATION_RESOLUTION state
* Conflicted federated identities MUST resolve to most restrictive emission state
* SUPPRESSED in any node → SUPPRESSED globally at API layer



## 10. IVL Dependency Constraint

From 05-03:

| IVL State   | API Emission State               |
| -- | -- |
| VISIBLE     | FULL_EMISSION / PARTIAL_EMISSION |
| CONDITIONAL | PARTIAL_EMISSION                 |
| RESTRICTED  | TOKENIZED_EMISSION               |
| DENIED      | SUPPRESSED_EMISSION              |

Constraint:

> IVL is resolved upstream; API only renders outcome.



## 11. Deterministic Emission Function

```text id="api_fn"
API_Output =
f(EDS, SchemaVersion, FederationState, SecurityConstraints)
```

Constraints:

* MUST be deterministic
* MUST be schema-version locked
* MUST NOT depend on runtime evaluation logic



## 12. Failure Model

### 12.1 EDS Missing

If Exposure Decision Set is unavailable:

* MUST return SUPPRESSED_EMISSION



### 12.2 Schema Mismatch

If schema version mismatch occurs:

* MUST suppress all outputs



### 12.3 Federation Conflict

If unresolved federated state exists:

* MUST downgrade to SUPPRESSED_EMISSION



## 13. Security Constraints

The External API Layer is the **highest exposure boundary**, therefore:

* No CIR exposure under any condition
* No reconstruction of APC or PIK/VSIG allowed from outputs
* No cross-response identity correlation beyond token scope
* No implicit identity graph leakage via repeated API calls

Security principle:

> The API layer exposes representations, not identity.



## 14. System Invariants

The following MUST always hold:

* API never accesses CIR directly
* API never evaluates IVL or APC
* EDS is the sole input source
* SUPPRESSED overrides all emissions
* Tokenized outputs must remain non-reversible
* No external call may increase identity resolution
