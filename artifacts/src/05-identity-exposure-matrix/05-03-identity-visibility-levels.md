## 1. Purpose

This document defines the **Identity Visibility Level (IVL) system**, the canonical classification model used by the Exposure Evaluation Engine to express how identity-related data is permitted to propagate through system boundaries.

Visibility levels provide a **normalized semantic interface** between domain-specific exposure evaluation and the final Exposure Decision Set (EDS).



## 2. Core Principle

Visibility levels are not permissions.

They are not authorizations.

They are:

> Deterministic classification states representing the outcome of exposure evaluation prior to final aggregation.

They function as an **intermediate semantic abstraction layer** between domain evaluation and cross-domain resolution.



## 3. Visibility Level Model

The Identity Visibility Level system defines four ordered states:

```
VISIBLE
CONDITIONAL
RESTRICTED
DENIED
```

These levels are strictly ordinal and form a monotonic restriction hierarchy:

```
VISIBLE → CONDITIONAL → RESTRICTED → DENIED
```



## 4. Formal Definition

Let:

* D = identity-related domain element
* E = exposure evaluation function
* S = schema constraints
* A = authorization context

Then:

```id="b6k9qp"
IVL(D) = E(D, A, S)
```

Where IVL(D) ∈ {VISIBLE, CONDITIONAL, RESTRICTED, DENIED}



## 5. Semantic Definitions

### 5.1 VISIBLE

Definition:

> The domain element is fully exposable under current schema and authorization constraints.

Properties:

* No masking required
* No conditional gating
* Fully included in downstream exposure candidates

Constraint:

* Still subject to cross-domain resolution in 05-02



### 5.2 CONDITIONAL

Definition:

> The domain element may be exposed only if additional deterministic constraints are satisfied.

Properties:

* Requires evaluation of secondary predicates
* May depend on contextual state (schema-defined only)
* Cannot be directly emitted without validation

Constraint:

* Conditions MUST be deterministic and version-locked



### 5.3 RESTRICTED

Definition:

> The domain element is partially exposable, requiring transformation or masking.

Properties:

* Field-level suppression permitted
* Redaction or anonymization may apply
* Structural presence may remain without full value exposure

Constraint:

* Must preserve structural integrity of output schema



### 5.4 DENIED

Definition:

> The domain element is not exposable under any valid evaluation path.

Properties:

* Must be excluded from all downstream outputs
* Cannot be partially represented
* Cannot be conditionally re-evaluated

Constraint:

* Terminal state (non-recoverable within evaluation cycle)



## 6. Ordering Semantics

Visibility levels follow a strict dominance hierarchy:

### 6.1 Dominance Rule

```
DENIED > RESTRICTED > CONDITIONAL > VISIBLE
```

Meaning:

* Higher severity overrides lower visibility
* Any conflict resolves to highest restriction level



### 6.2 Merge Rule

When multiple evaluations produce conflicting IVLs for the same domain element:

```id="z9c2lx"
IVL_final = max_restriction(IVL_set)
```

Where `max_restriction` selects the most restrictive state.



## 7. Domain Application Model

IVLs are applied uniformly across all exposure domains:

### 7.1 Identity Attribute Domain

* CIR fields
* Identity identifiers
* Structural identity metadata

### 7.2 Registry State Domain

* Lifecycle state
* Persistence flags
* System registration status

### 7.3 Authorization Context Domain

* Effective RBAC outcomes
* Delegation constraints
* Service identity scopes

### 7.4 Representation Domain

* AER eligibility evaluation
* Emission gating classification
* Output transform constraints



## 8. Determinism Requirements

The IVL system MUST satisfy:

### 8.1 Input Determinism

Identical inputs produce identical IVLs.

### 8.2 Schema Determinism

All IVL evaluations MUST be bound to version-locked schema definitions.

### 8.3 Context Isolation

IVL computation MUST NOT depend on:

* runtime state outside evaluation inputs
* external services
* non-versioned configuration

### 8.4 Evaluation Stability

IVLs MUST remain stable across evaluation cycles given identical inputs.



## 9. Integration with Exposure Evaluation Pipeline

IVLs are produced in:

> Stage 4 — Domain Exposure Evaluation (05-02)

They are then consumed by:

> Stage 5 — Cross-Domain Resolution

### Flow:

```
Domain Input → IVL Assignment → Cross-Domain Merge → Resolved Visibility State
```



## 10. IVL Transition Constraints

Transitions between IVLs are strictly unidirectional:

```
VISIBLE → CONDITIONAL → RESTRICTED → DENIED
```

Reverse transitions are prohibited within a single evaluation cycle.

Exception:

* Re-evaluation after full pipeline restart (new execution cycle only)



## 11. Failure Semantics

### 11.1 Invalid IVL Assignment

If a domain evaluation produces an invalid state:

* MUST default to DENIED

### 11.2 Partial Evaluation Failure

If evaluation cannot complete:

* IVL MUST be DENIED for affected domain

### 11.3 Schema Mismatch

If schema version conflict exists:

* IVL MUST resolve to DENIED



## 12. Security Model

IVLs enforce a **monotonic restriction security model**:

* No IVL can increase visibility once assigned
* No IVL can bypass higher restriction states
* DENIED is terminal and absolute

Security principle:

> Visibility can only decrease through evaluation, never increase.



## 13. System Invariants

The following MUST always hold:

* IVLs are deterministic outputs of schema-bound evaluation
* DENIED overrides all other states in aggregation
* IVL evaluation is stateless across cycles
* No external system may modify IVL results post-generation
* IVLs are immutable within a single evaluation pipeline
