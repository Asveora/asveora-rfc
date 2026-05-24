## 1. Purpose

This document defines the **Exposure Model Core**, the canonical evaluation model used by the Identity Exposure Matrix (IEM) to determine **visibility eligibility** over identity-derived data.

It formalizes the rules, structures, and evaluation semantics by which internal system state is transformed into a **deterministic visibility decision space**.

The Exposure Model is not a representation system.

It is a **constraint evaluation system over already-resolved identity + authorization state**.



## 2. Model Definition

The Exposure Model is defined as:

> A deterministic mapping function from system state inputs → visibility constraints → exposure decision outputs.

Formally:

```
E: (CIR, RegistryState, AuthorizationContext, SchemaSet) → ExposureDecisionSet
```

Where:

* **CIR** = canonical identity truth
* **RegistryState** = system persistence snapshot
* **AuthorizationContext** = resolved RBAC + delegation closure (Layer 5)
* **SchemaSet** = version-locked machine-enforced definitions



## 3. Core Concept: Exposure as Constraint Evaluation

Exposure is NOT:

* Identity transformation
* Permission computation
* Representation formatting
* AER generation

Exposure IS:

> The evaluation of whether identity-linked data may pass through a visibility boundary under deterministic constraints.



## 4. Exposure Domains

The model evaluates exposure across four canonical domains:

### 4.1 Identity Attribute Domain

Covers CIR fields such as:

* Identity identifiers (PIK, AUID, VSIG, etc.)
* Structural identity metadata
* Identity linkage references

### 4.2 Registry State Domain

Covers:

* Persistence-level identity state
* System registration status
* Lifecycle flags (active, suspended, deprecated)

### 4.3 Authorization Context Domain

Derived from Layer 5 schema system:

* Effective RBAC grants
* Delegation chains
* Service identity privileges

### 4.4 Derived Representation Domain

Covers:

* AER eligibility evaluation
* Representation-class visibility conditions
* Downstream API emission gating



## 5. Exposure Evaluation Function

Each domain is evaluated via a uniform function:

```
Expose(domain_state, authorization_context, schema_rules) → VisibilityState
```

Where VisibilityState ∈:

* `VISIBLE`
* `CONDITIONAL`
* `RESTRICTED`
* `DENIED`



## 6. Visibility State Semantics

### 6.1 VISIBLE

* Full exposure permitted within schema-defined constraints
* No additional filtering required

### 6.2 CONDITIONAL

* Exposure permitted only if additional runtime constraints are satisfied
* Constraints MUST be deterministic and schema-defined

### 6.3 RESTRICTED

* Partial exposure allowed
* Requires masking or field-level suppression

### 6.4 DENIED

* No exposure permitted
* Output must be fully suppressed



## 7. Evaluation Hierarchy

Exposure evaluation MUST follow strict precedence ordering:

### Step 1 — Schema Constraint Evaluation

* Apply schema-defined exposure rules first
* Establish hard boundaries

### Step 2 — Authorization Binding Application

* Apply resolved Layer 5 authorization closure
* Reduce permissible exposure set

### Step 3 — Domain-Specific Evaluation

* Evaluate each exposure domain independently
* Produce domain-level visibility states

### Step 4 — Cross-Domain Conflict Resolution

* Resolve inconsistencies using schema precedence rules
* Fail-closed on unresolved conflicts

### Step 5 — Final Exposure Composition

* Aggregate domain states into Exposure Decision Set (EDS)



## 8. Exposure Decision Set (EDS) Structure

The Exposure Model outputs:

```
EDS = {
  identity_domain_state,
  registry_domain_state,
  authorization_domain_state,
  representation_domain_state,
  global_visibility_mask,
  aer_eligibility_flags
}
```

### Key Constraint:

EDS is immutable post-generation.



## 9. Deterministic Evaluation Rules

The Exposure Model MUST guarantee:

### 9.1 Input Determinism

Identical inputs produce identical outputs.

### 9.2 Order Determinism

Evaluation order is fixed and must not vary across executions.

### 9.3 Schema Locking

All schema references must be version-resolved prior to evaluation.

### 9.4 No External Dependencies

Evaluation MUST NOT:

* Query external services
* Access runtime policy injection systems
* Depend on non-versioned state



## 10. Exposure Boundaries

Exposure boundaries define what can NEVER be overridden within this model:

* CIR cannot be altered or reinterpreted
* Authorization cannot be escalated within exposure logic
* Schema constraints override all RFC-level ambiguity
* Registry state is read-only



## 11. AER Interaction Constraint

AER is strictly downstream.

Within the Exposure Model:

* AER is NOT generated
* AER is NOT formatted
* AER is NOT interpreted

Only evaluation is permitted:

```
aer_eligibility ∈ {ELIGIBLE, INELIGIBLE, CONDITIONAL}
```



## 12. Conflict Resolution Strategy

When conflicting visibility states arise:

### Resolution Priority:

1. DENIED overrides all states
2. RESTRICTED overrides CONDITIONAL and VISIBLE
3. CONDITIONAL overrides VISIBLE
4. VISIBLE applies only if no higher constraint exists

### Unresolvable Conflicts:

* MUST result in DENIED (fail-closed behavior)



## 13. Failure Model

### 13.1 Input Incompleteness

If any required input is missing:

* Abort evaluation
* Return DENIED state

### 13.2 Schema Conflict

If schema versions mismatch:

* Enter fail-closed mode
* Output DENIED only

### 13.3 Authorization Inconsistency

If Layer 5 closure is invalid:

* Exposure evaluation MUST NOT proceed



## 14. Security Guarantees

The Exposure Model enforces:

* No privilege escalation pathways
* No identity mutation capability
* No schema override capability
* No representation synthesis capability

Security principle:

> Exposure can only reduce visibility, never increase authority.



## 15. System Invariants

The following invariants MUST always hold:

* Visibility ≤ Authorization scope
* Exposure cannot exceed schema-defined limits
* DENIED is terminal
* CIR is immutable throughout evaluation
* EDS is deterministic and reproducible
