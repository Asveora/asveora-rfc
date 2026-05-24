## 1. Purpose

This document defines the **canonical evaluation order** for the Identity Exposure Matrix (IEM).

It formalizes the deterministic execution sequence that governs how exposure decisions are computed from system inputs.

This specification ensures:

> Every exposure decision is produced through a strictly ordered, reproducible pipeline with no runtime variability.



## 2. Core Principle: Evaluation Order Supremacy

The Exposure Evaluation Order is a **hard execution constraint**, not a recommendation.

It overrides:

* Implementation optimizations
* Internal caching strategies
* Parallel execution opportunities (unless order-preserving)

Rule:

> Correct ordering is mandatory even if it reduces efficiency.



## 3. Evaluation Pipeline Overview

The Exposure Evaluation Pipeline consists of six deterministic stages:

```
Stage 1 → Input Normalization  
Stage 2 → Schema Resolution Lock  
Stage 3 → Authorization Binding Integration  
Stage 4 → Domain Exposure Evaluation  
Stage 5 → Cross-Domain Resolution  
Stage 6 → Exposure Decision Set Assembly
```

Each stage MUST complete fully before the next begins.



## 4. Stage 1 — Input Normalization

### 4.1 Purpose

Standardize all incoming system inputs into canonical evaluation-ready structures.

### 4.2 Inputs

* CIR snapshot
* Registry state snapshot
* Authorization context (pre-resolution)
* Schema references

### 4.3 Processing Rules

* Validate structural integrity of CIR
* Normalize registry state format
* Ensure authorization context is syntactically valid (not yet semantically resolved)
* Reject malformed or partial inputs

### 4.4 Output

* NormalizedEvaluationBundle (NEB)



## 5. Stage 2 — Schema Resolution Lock

### 5.1 Purpose

Freeze all schema versions used during evaluation.

### 5.2 Rules

* All schema references MUST be resolved to explicit version identifiers
* No dynamic schema loading permitted beyond this point
* Schema mutation is prohibited during evaluation lifecycle

### 5.3 Output

* SchemaLockedContext (SLC)

This ensures deterministic evaluation across executions.



## 6. Stage 3 — Authorization Binding Integration

### 6.1 Purpose

Integrate Layer 5 Authorization Schema outputs into the evaluation context.

### 6.2 Inputs

* NormalizedEvaluationBundle (NEB)
* SchemaLockedContext (SLC)
* Layer 5 resolved authorization graph

### 6.3 Processing Rules

* Compute effective authorization closure
* Bind RBAC + delegation relationships into identity context
* Resolve service identity privileges into unified authorization map

### 6.4 Output

* AuthorizationBoundContext (ABC)

Constraint:

> This stage does NOT evaluate visibility. It only resolves authority.



## 7. Stage 4 — Domain Exposure Evaluation

### 7.1 Purpose

Evaluate exposure state across all defined domains.

### 7.2 Domains

* Identity Attribute Domain
* Registry State Domain
* Authorization Context Domain
* Derived Representation Domain

### 7.3 Processing Rules

Each domain is evaluated independently using Exposure Model function:

```
VisibilityState = Evaluate(domain, ABC, SLC)
```

### 7.4 Output

* DomainVisibilityMap (DVM)

Each domain produces one of:

* VISIBLE
* CONDITIONAL
* RESTRICTED
* DENIED



## 8. Stage 5 — Cross-Domain Resolution

### 8.1 Purpose

Resolve conflicts between domain-level visibility outcomes.

### 8.2 Conflict Scenarios

* Identity domain = VISIBLE, Authorization domain = RESTRICTED
* Registry domain = CONDITIONAL, Representation domain = DENIED

### 8.3 Resolution Rules (Strict Precedence)

1. DENIED overrides all other states
2. RESTRICTED overrides CONDITIONAL and VISIBLE
3. CONDITIONAL overrides VISIBLE
4. VISIBLE only applies if no higher constraint exists

### 8.4 Failure Condition

If conflict cannot be resolved deterministically:

* System MUST default to DENIED (fail-closed)

### 8.5 Output

* ResolvedVisibilityState (RVS)



## 9. Stage 6 — Exposure Decision Set Assembly

### 9.1 Purpose

Construct final Exposure Decision Set (EDS) output.

### 9.2 Inputs

* ResolvedVisibilityState (RVS)
* DomainVisibilityMap (DVM)
* AuthorizationBoundContext (ABC)
* SchemaLockedContext (SLC)

### 9.3 Processing Rules

* Aggregate all visibility states into structured output
* Compute global visibility mask
* Evaluate AER eligibility flags (evaluation only)
* Attach contextual metadata (non-authoritative)

### 9.4 Output Structure

```id="4v5r8k"
EDS = {
  domain_visibility_map,
  resolved_visibility_state,
  global_visibility_mask,
  aer_eligibility_flags,
  evaluation_metadata
}
```



## 10. Determinism Enforcement

The evaluation order guarantees:

### 10.1 Strict Sequencing

* No stage may execute out of order
* No stage may be skipped

### 10.2 Input Immutability

* Inputs MUST remain unchanged after Stage 1

### 10.3 Schema Lock Enforcement

* Schema resolution is final at Stage 2
* No mid-evaluation schema switching allowed

### 10.4 Parallelism Constraint

* Parallel execution allowed ONLY within Stage 4 domain evaluation
* Cross-stage parallelism is forbidden



## 11. Failure Handling Model

### 11.1 Stage Failure Behavior

Any failure in any stage results in:

> Immediate termination of pipeline execution

### 11.2 Default Failure State

* Output MUST be DENIED exposure state
* No partial EDS may be emitted

### 11.3 Failure Categories

* Input invalidation → Stage 1 failure
* Schema mismatch → Stage 2 failure
* Authorization inconsistency → Stage 3 failure
* Evaluation error → Stage 4/5 failure



## 12. Security Constraints

This evaluation order enforces:

* No bypass of authorization binding stage
* No exposure evaluation before schema locking
* No partial output leakage
* No runtime privilege escalation paths

Security principle:

> Ordering is a security boundary, not just an execution constraint.



## 13. System Invariants

The following MUST always hold:

* Stage order is immutable
* Schema locking precedes all evaluation
* Authorization binding precedes exposure evaluation
* Cross-domain resolution precedes final output assembly
* Fail-closed behavior applies to all unresolved states
