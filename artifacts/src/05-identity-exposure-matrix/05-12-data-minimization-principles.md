## 1. Purpose

This document defines the **Data Minimization Principles (DMP)** governing the reduction, restriction, and controlled suppression of identity-related data across all Asveora exposure and indexing systems.

Data minimization is a **global constraint layer** applied after identity resolution and before external observability.

This specification governs:

> How identity data is reduced to the minimal necessary representation required for system function, without compromising structural correctness or evaluation determinism.



## 2. Core Principle

The Asveora system enforces **minimum necessary identity exposure at all layers**.

Therefore:

> No identity component may be exposed, indexed, or transmitted unless it is strictly required for evaluation, resolution, or authorized external representation.

Key constraint:

> Data minimization overrides all non-critical visibility, indexing, and federation behaviors.



## 3. Minimization Hierarchy

Data minimization operates as a hierarchical constraint applied in descending order:

```text id="dmp_hierarchy"
CIR → APC → AUID → EDS → API → INDEX
```

At each stage:

* unnecessary fields MUST be removed
* sensitive components MUST be abstracted or suppressed
* derivable data MUST NOT be redundantly emitted



## 4. Core Minimization Rules

### 4.1 Necessity Rule

Only data required for:

* identity resolution
* authorization evaluation
* authorized exposure rendering

MAY be retained.

All other data MUST be removed.



### 4.2 Non-Derivation Rule

If a value can be derived from another value within the same context:

> It MUST NOT be explicitly emitted.

Example:

* If AUID implies APC → APC must not be separately emitted unless required
* If APC implies PIK/VSIG → components must remain suppressed unless explicitly allowed



### 4.3 No Redundant Exposure Rule

No identity component may be duplicated across layers unless:

* required for deterministic evaluation
* required for federation reconciliation
* required for API compliance

Otherwise:

> duplication is forbidden



### 4.4 Suppression Priority Rule

Suppression is always preferred over masking or tokenization when ambiguity exists.

Priority order:

```text id="dmp_priority"
SUPPRESS > TOKENIZE > MASK > EXPOSE
```



## 5. Layer-Based Minimization Application

### 5.1 CIR Layer

* CIR is never emitted
* CIR is never partially exposed
* CIR is strictly internal derivation only



### 5.2 APC Layer

* APC MAY be partially exposed only under strict IVL alignment
* VSIG must remain suppressed unless explicitly required
* PIK exposure must be justified by evaluation necessity



### 5.3 AUID Layer

* AUID is the primary external descriptor
* Must be minimized to essential structural form
* Optional components MUST be removed unless required for resolution



### 5.4 API Layer

* Only emits EDS-approved minimal representation
* Must not include internal evaluation metadata
* Must not expose derivation traces



### 5.5 Index Layer

* Only stores minimal searchable representation
* Must not store reconstructable identity chains
* Must not store redundant descriptors beyond query necessity



## 6. Data Reduction Model

Minimization is defined as:

```text id="dmp_model"
M(data) = f(required_components, exposure_state, schema_constraints)
```

Where:

* unnecessary fields are eliminated
* sensitive fields are abstracted or suppressed
* structural validity is preserved

Constraint:

> Output MUST remain functionally equivalent for evaluation purposes.



## 7. Cross-System Minimization Rules

### 7.1 Federation Systems

From 05-08:

* Only minimal identity representation is transmitted
* No raw APC or CIR propagation permitted
* Conflicted states MUST resolve to most minimal form



### 7.2 Indexing Systems

From 05-11:

* Only indexable minimal descriptors are stored
* No reconstructable identity structures permitted
* NULL_INDEX used when minimization removes all meaningful data



### 7.3 API Systems

From 05-10:

* API MUST emit only minimized EDS outputs
* No internal state leakage allowed
* No redundant metadata permitted



## 8. Deterministic Minimization Function

```text id="dmp_fn"
MinimalState =
f(CIR, APC, AUID, IVL, FederationState, SchemaConstraints)
```

Constraints:

* MUST be deterministic
* MUST be schema-version locked
* MUST produce identical outputs for identical inputs



## 9. Failure Model

### 9.1 Over-Exposure Detection

If unnecessary identity data is detected:

* MUST be removed prior to emission



### 9.2 Under-Resolution Risk

If minimization removes required evaluation data:

* MUST fallback to SUPPRESSED state



### 9.3 Schema Conflict

If minimization rules conflict:

* MUST default to most restrictive interpretation



## 10. Security Constraints

Data minimization is a **system-wide security enforcement layer**, therefore:

* No identity component may be exposed without necessity justification
* No reconstruction pathways may survive minimization
* No federated or indexed system may bypass minimization rules
* No API output may exceed minimal required representation

Security principle:

> The system must expose the least possible identity state that still preserves correctness.



## 11. System Invariants

The following MUST always hold:

* CIR is never exposed under any minimization condition
* SUPPRESSED is the default safe fallback state
* No redundant identity data exists across layers
* TOKENIZED outputs must remain minimal and non-reversible
* Minimization always applies after evaluation, before emission

