## 1. Purpose

This document defines the reference implementation guidelines for the Asveora system.

It establishes a canonical behavioral blueprint for implementing:

* identity resolution
* registry interaction
* authorization evaluation
* federation consistency
* exposure evaluation
* API emission behavior
* governance audit integration



## 2. Reference Implementation Definition

A reference implementation is defined as:

> A deterministic, schema-compliant system implementation that faithfully enforces all Asveora RFC constraints without introducing additional behavior, inference logic, or policy extensions.

### Constraint

> A reference implementation MUST NOT extend system semantics beyond RFC-defined rules.



## 3. Implementation Philosophy

All implementations SHOULD adhere to the following principles:

### 3.1 Deterministic Execution

* identical inputs MUST produce identical outputs
* no probabilistic evaluation is permitted

### 3.2 Schema-First Design

* schema validation precedes all system logic
* schema defines enforceable structural truth, not interpretation

### 3.3 Layer Isolation

* each subsystem operates within strict boundaries
* no cross-layer authority leakage is permitted

### 3.4 Fail-Closed Behavior

* ambiguity resolves to denial or suppression
* incomplete state MUST NOT be emitted



## 4. System Execution Model

Reference implementations MUST follow this canonical pipeline:

```text id="ref_impl_pipeline"
Schema Validation
    ↓
Identity Resolution (CIR / APC / VSIG / AUID)
    ↓
Registry Validation
    ↓
Authorization Evaluation (RBAC / delegation / service identity)
    ↓
Federation Consistency Check (transport-only)
    ↓
Exposure Evaluation (EDS filtering)
    ↓
API Emission or Suppression
    ↓
Governance Audit Recording (non-blocking)
```



## 5. Identity Implementation Guidelines

### 5.1 CIR Handling

* CIR is the authoritative identity state anchor
* all identity evaluation MUST resolve to CIR validity first

### 5.2 APC Construction

* APC format MUST be:
  `[PIK]-[VSIG]`
* both components MUST be registry-valid

### 5.3 AUID Construction

* AUID format MUST be:
  `[APA]=[PIK]-[VSIG]`
* AUID is a derived descriptor, not an authority source

### 5.4 Identity Validity Constraint

> Any identity component not bound to registry state MUST be treated as invalid



## 6. Registry Implementation Guidelines

### 6.1 State Authority

* registry is the sole persistence layer for identity state
* all mutations MUST be registry-authorized

### 6.2 Mutation Model

* updates MUST be atomic
* partial writes are invalid
* concurrent mutation MUST be serialized

### 6.3 Consistency Enforcement

* stale or divergent states MUST be rejected
* migration artifacts MUST not persist outside lifecycle bounds



## 7. Authorization Implementation Guidelines

### 7.1 RBAC Model

* permissions MUST be explicitly defined
* no implicit privilege escalation is permitted

### 7.2 Delegation Model

* delegation MUST be explicitly scoped
* delegation chains MUST be verifiable and bounded

### 7.3 Service Identity Model

* service identities MUST be registry-bound
* impersonation MUST be rejected deterministically



## 8. Federation Implementation Guidelines

### 8.1 Consistency Model

* federation is a synchronization mechanism only
* local state validation overrides remote state

### 8.2 Divergence Handling

* divergent states MUST be suppressed or reconciled
* unresolved divergence triggers fail-closed behavior

### 8.3 Synchronization Constraint

> Federation MUST NOT introduce new authoritative state



## 9. Exposure Implementation Guidelines

### 9.1 EDS Pipeline

Exposure evaluation MUST follow:

```text id="eds_pipeline"
Identity Validation
    ↓
Authorization Validation
    ↓
Registry Validation
    ↓
Federation Transport Consistency Check
    ↓
Exposure Filtering
    ↓
Emission or Suppression
```

### 9.2 Non-Reconstructive Guarantee

* outputs MUST NOT allow identity reconstruction
* CIR/APC/VSIG MUST remain non-inferable

### 9.3 Suppression Rule

* uncertain states MUST be suppressed
* partial visibility is not permitted



## 10. API Implementation Guidelines

### 10.1 Emission-Only Model

* API MUST NOT compute identity or authorization logic
* API only emits pre-evaluated results

### 10.2 Precondition Requirement

* all API inputs MUST already be schema-validated
* API MUST assume upstream correctness enforcement

### 10.3 Safety Constraint

> API MUST NOT expose internal evaluation pipeline state



## 11. Governance Integration Guidelines

### 11.1 Authority Model

* governance produces audit events for all system layers
* governance MUST NOT override, block, or modify runtime behavior

### 11.2 Enforcement Scope

* applies to observability and audit only
* does not affect execution outcomes



## 12. Fail-Closed Implementation Behavior

All implementations MUST enforce:

* DENIED → invalid or unauthorized operations
* SUPPRESSED → unsafe or reconstructive outputs
* RESTRICTED → constrained valid subset
* INVALIDATED → broken or stale state
* CONFLICTED → unresolved divergence



## 13. Determinism Requirement

Implementations MUST ensure:

* no nondeterministic branching
* no hidden state dependency
* no timing-based evaluation differences affecting correctness



## 14. Implementation Anti-Patterns (Prohibited)

The following are explicitly disallowed:

* probabilistic identity resolution
* partial exposure emission
* implicit authorization inference
* cross-layer state leakage
* non-registry-backed identity acceptance
* federation-as-authority behavior
* governance-as-execution-control behavior



## 15. System Invariant Preservation

Reference implementations MUST preserve:

* schema supremacy
* registry projection authority
* deterministic evaluation
* fail-closed safety
* non-reconstructive exposure
* strict layer isolation
* audit-only governance model
