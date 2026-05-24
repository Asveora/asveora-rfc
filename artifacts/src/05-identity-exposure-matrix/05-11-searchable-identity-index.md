## 1. Purpose

This document defines the **Searchable Identity Index (SII)**, which governs how identity-related representations are made discoverable within constrained indexing systems.

The Searchable Identity Index is an **observability layer**, not a truth layer.

This specification governs:

> How AUID-derived, APC-derived, and tokenized identity representations may be indexed, queried, and retrieved without exposing CIR or violating upstream exposure constraints.



## 2. Core Principle

The Searchable Identity Index is **derivative-only and non-reconstructive**.

Therefore:

> The index MUST NOT contain any data capable of reconstructing CIR, APC, PIK, or VSIG.

Key constraint:

> The index is a navigational structure over permitted exposure outputs, not an identity resolution system.



## 3. Index Input Model

The Searchable Identity Index ONLY accepts inputs from:

```text id="sii_input"
Exposure Decision Set (EDS)
External API Emission Layer (05-10 outputs)
```

It MUST NOT consume:

* CIR
* raw APC
* raw PIK
* raw VSIG



## 4. Indexed Identity Units

The SII supports indexing of the following **approved representations only**:

* AUID (fully or partially exposed)
* TOKENIZED identity references
* HASHED APC representations
* MASKED or SEGMENTED identity fragments
* SUPPRESSED markers (as null index entries)

Constraint:

> No raw identity component is ever indexed directly.



## 5. Indexability States

Each identity representation is assigned one of the following index states:

```text id="sii_states"
INDEXABLE
PARTIALLY_INDEXABLE
NON_INDEXABLE
NULL_INDEX
```



## 6. State Definitions

### 6.1 INDEXABLE

Definition:

> Identity representation is fully searchable and retrievable.

Conditions:

* AUID is FULLY_EXPOSED or valid TOKENIZED form
* No sensitive components exposed
* Passes all upstream evaluation layers

Properties:

* Fully queryable
* Stable retrieval keys
* No identity reconstruction risk



### 6.2 PARTIALLY_INDEXABLE

Definition:

> Identity representation is searchable with restricted visibility.

Conditions:

* SEGMENTED or PARTIAL_EMISSION AUID
* Masked APC components
* Tokenized hybrid structures

Properties:

* Query returns constrained view
* No full identity reconstruction allowed
* Context-dependent results



### 6.3 NON_INDEXABLE

Definition:

> Identity representation must not be searchable.

Conditions:

* SUPPRESSED_EMISSION state
* DENIED IVL state
* Invalid APC or VSIG failure

Properties:

* Excluded from all index structures
* No query routing permitted
* No metadata exposure



### 6.4 NULL_INDEX

Definition:

> Placeholder entry representing suppressed or unresolved identity states.

Properties:

* Exists only for structural completeness
* Contains no identity data
* Cannot be dereferenced

Constraint:

> NULL_INDEX MUST NOT resolve to any identity state.



## 7. Index Construction Rules

### 7.1 Derivative-Only Rule

The index MUST be constructed solely from:

* AUID outputs
* API emission layer (05-10)
* EDS-approved representations



### 7.2 No Upward Inference Rule

The index MUST NOT allow reconstruction of:

* CIR
* APC structure
* PIK or VSIG components

Even partial inference is prohibited.



### 7.3 Deterministic Index Rule

Index entries MUST be:

* deterministic across identical EDS inputs
* schema-version locked
* independent of runtime execution variance



## 8. Query Model

Index queries operate over **exposed representations only**.

### 8.1 Allowed Query Types

* AUID lookup
* TOKEN search
* hashed identity matching
* partial descriptor matching (SEGMENTED mode)



### 8.2 Forbidden Query Types

* CIR queries
* raw PIK/VSIG queries
* reconstruction-based queries
* federation traversal queries that bypass exposure rules



## 9. Federation Interaction

From 05-08:

* Federated identities MUST be reconciled before indexing
* CONFLICTED federation states resolve to NON_INDEXABLE
* SUPPRESSED in any node → global NON_INDEXABLE

Constraint:

> Federation cannot increase indexability.



## 10. API Dependency Alignment

From 05-10:

Index ingestion MUST ONLY occur after:

```text id="sii_pipeline"
CIR → APC → AUID → EDS → API → INDEX
```

Rules:

* API is the sole ingestion source
* EDS is authoritative input
* CIR/APC never directly enter index



## 11. IVL Dependency Mapping

| IVL State   | Index State         |
| -- | - |
| VISIBLE     | INDEXABLE           |
| CONDITIONAL | PARTIALLY_INDEXABLE |
| RESTRICTED  | PARTIALLY_INDEXABLE |
| DENIED      | NON_INDEXABLE       |



## 12. Deterministic Index Function

```text id="sii_fn"
IndexState =
f(AUID, EDS, FederationState, IVL, SchemaConstraints)
```

Constraints:

* MUST be deterministic
* MUST be schema-version locked
* MUST not depend on CIR or APC raw evaluation



## 13. Failure Model

### 13.1 Missing EDS

* MUST produce NON_INDEXABLE or NULL_INDEX



### 13.2 Schema Conflict

* MUST default to NON_INDEXABLE



### 13.3 Federation Conflict

* MUST resolve to NON_INDEXABLE



### 13.4 Invalid Identity State

* MUST produce NULL_INDEX only



## 14. Security Constraints

The Searchable Identity Index is a **controlled observability surface**, therefore:

* No identity reconstruction is possible through queries
* No CIR/APC leakage through indexing metadata
* No federated inference escalation allowed
* No token reversal permitted

Security principle:

> The index is a map of allowed visibility, not a system of identity resolution.



## 15. System Invariants

The following MUST always hold:

* Index contains no CIR-derived raw data
* SUPPRESSED always results in NON_INDEXABLE or NULL_INDEX
* TOKENIZED entries remain non-reversible
* Federation cannot increase index scope
* API layer is the only ingestion boundary
