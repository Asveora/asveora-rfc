## 1. Purpose

This document defines the threat model, lifecycle failure modes, and integrity constraints associated with detached identity states in the Asveora system.

Detached identity refers to:

> Any identity component (CIR-derived structure, APC, VSIG, AUID, or derived representation) that is no longer coherently bound to an active, valid, and consistent identity lifecycle state within the registry system.

This specification governs:

* orphaned identity artifacts
* stale identity reuse
* lifecycle-disconnected identity propagation
* registry-unbound identity references
* partially revoked identity structures
* migration-origin residual identities
* federation-decoupled identity remnants



## 2. Core Principle

Identity in Asveora is lifecycle-bound and registry-coherent.

Therefore:

> Any identity representation that is not anchored to a valid, current registry-backed lifecycle state MUST be considered non-authoritative and unsafe for evaluation.

Key implication:

* identity validity is inseparable from lifecycle continuity



## 3. Detached Identity Definition

A detached identity state exists when:

* CIR linkage is missing or invalid
* APC is no longer registry-consistent
* VSIG cannot be validated against current state
* AUID no longer resolves to a valid lifecycle path
* registry state has been superseded or invalidated
* federation state is inconsistent or stale
* exposure state persists without valid backing identity

Constraint:

> Detached identity MUST NOT be treated as valid identity under any evaluation layer.



## 4. Protected Lifecycle Properties

The system MUST preserve:

* lifecycle continuity
* registry coherence
* identity-state binding integrity
* revocation consistency
* migration atomicity
* federation synchronization correctness
* exposure-state validity alignment

Compromise of lifecycle integrity MUST invalidate dependent identity structures.



## 5. Detached Identity Risk Categories

Detached identity risks are classified as:

```text id="detached_identity_categories"
ORPHANED_IDENTITY
STALE_LIFECYCLE_REUSE
REGISTRY_UNBOUND_REFERENCE
PARTIALLY_REVOKED_STATE
MIGRATION_RESIDUE
FEDERATION_DECOUPLED_STATE
EXPOSURE_WITHOUT_BACKING_IDENTITY
```



## 6. Threat Definitions

### 6.1 ORPHANED_IDENTITY

Definition:

> Identity components with no valid CIR or registry linkage.

Examples:

* AUID with missing CIR resolution
* APC without registry confirmation
* VSIG without lineage validation

Constraint:

> Orphaned identities MUST be rejected as non-authoritative.



### 6.2 STALE_LIFECYCLE_REUSE

Definition:

> Reuse of identity state that has been superseded by lifecycle transitions.

Examples:

* outdated AUID after migration
* expired identity snapshot reuse
* deprecated registry state replay

Constraint:

> Lifecycle supersession MUST invalidate prior identity state.



### 6.3 REGISTRY_UNBOUND_REFERENCE

Definition:

> Identity references that exist outside active registry state.

Examples:

* cached identity entries not in registry
* API-derived identities without registry validation
* external system references without synchronization

Constraint:

> Registry is the sole authority for identity persistence.



### 6.4 PARTIALLY_REVOKED_STATE

Definition:

> Identity states where revocation has propagated inconsistently across system layers.

Examples:

* VSIG revoked but AUID still exposed
* partial federation revocation delay
* incomplete registry cleanup

Constraint:

> Revocation MUST be atomic and fully propagated.



### 6.5 MIGRATION_RESIDUE

Definition:

> Identity artifacts remaining after completed or aborted migration processes.

Examples:

* duplicate identity remnants post-migration
* stale APC after identity transfer
* orphaned registry entries

Constraint:

> Migration MUST be atomic or fully reconciled.



### 6.6 FEDERATION_DECOUPLED_STATE

Definition:

> Identity states that have diverged across federated systems.

Examples:

* inconsistent CIR resolution across nodes
* mismatched registry synchronization
* stale federated AUID exposure

Constraint:

> Federation divergence MUST resolve toward restriction.



### 6.7 EXPOSURE_WITHOUT_BACKING_IDENTITY

Definition:

> Identity representations exposed without valid underlying lifecycle state.

Examples:

* indexed AUID without registry backing
* API-exposed identity after revocation
* cached exposure fragments without CIR resolution

Constraint:

> Exposure MUST always require valid lifecycle backing.



## 7. Lifecycle Validation Requirements

Detached identity evaluation MUST include:

```text id="detached_validation"
CIR_VALIDATION
REGISTRY_VALIDATION
LIFECYCLE_VALIDATION
REVOCATION_VALIDATION
FEDERATION_VALIDATION
EXPOSURE_VALIDATION
```

Failure at any stage MUST result in suppression or invalidation.



## 8. Validation Ordering Constraints

Lifecycle validation MUST follow deterministic order:

```text id="detached_order"
CIR Resolution
    ↓
Registry State Validation
    ↓
Lifecycle State Validation
    ↓
Revocation State Validation
    ↓
Federation Consistency Check
    ↓
Exposure Eligibility Evaluation
```

Constraint:

> No identity evaluation MAY occur outside lifecycle-validated state.



## 9. Registry Dependency Constraints

The registry system is the authoritative persistence layer.

Therefore:

* all identity states MUST originate or be validated against registry
* unregistered identity state MUST be rejected
* stale registry snapshots MUST NOT be used for validation
* registry divergence MUST result in restriction

Constraint:

> Identity without registry coherence is invalid by definition.



## 10. Revocation Integrity Requirements

Revocation MUST:

* propagate across all identity representations
* invalidate CIR-linked structures where applicable
* remove APC and VSIG validity
* suppress AUID exposure
* terminate federation propagation

Constraint:

> Revocation is absolute and overrides all downstream identity representations.



## 11. Federation Constraints

Federated systems MUST:

* synchronize lifecycle state deterministically
* reject divergent identity states
* suppress decoupled identity artifacts
* maintain consistency with registry authority

Constraint:

> Federation cannot resurrect detached identity state.



## 12. Exposure Constraints

From Section 5:

* exposure is dependent on lifecycle validity
* suppression is irreversible

Therefore:

* detached identities MUST NOT be exposed
* stale identity state MUST NOT be indexed
* API MUST NOT emit lifecycle-invalid identities



## 13. API Constraints

From Section 6-07:

* API is emission-only
* API cannot validate identity state

Therefore:

* API MUST rely on pre-validated lifecycle state
* API MUST NOT reconstruct identity validity
* API MUST suppress detached identity outputs



## 14. Migration Constraints

Identity migration MUST:

* preserve atomicity
* maintain registry consistency
* ensure no residual identity artifacts remain
* prevent duplication or divergence
* enforce deterministic rollback or commit behavior

Constraint:

> Migration cannot produce valid detached identity states.



## 15. Detection Requirements

Implementations SHOULD detect:

* orphaned identity references
* stale lifecycle reuse patterns
* registry mismatch anomalies
* federation divergence signals
* partial revocation propagation
* migration residue artifacts

Detection systems MUST NOT override deterministic suppression outcomes.



## 16. Security Constraints

The system MUST ensure:

* identity is always lifecycle-bound
* registry is the authoritative identity source
* revocation is fully propagated
* federation cannot revalidate detached state
* exposure cannot persist without valid backing identity

Security principle:

> Detached identity state is inherently invalid, regardless of structural correctness.



## 17. Failure Behavior

The following failures MUST resolve toward restriction:

| Failure Type                      | Result      |
|  | -- |
| Orphaned identity                 | SUPPRESSED  |
| Stale lifecycle reuse             | INVALIDATED |
| Registry mismatch                 | FAIL-CLOSED |
| Partial revocation                | CONFLICTED  |
| Federation divergence             | RESTRICTED  |
| Migration residue                 | SUPPRESSED  |
| Exposure without backing identity | FAIL-CLOSED |



## 18. System Invariants

The following MUST always hold:

* identity validity requires lifecycle coherence
* registry state is authoritative
* revocation is globally consistent
* federation cannot restore invalid state
* API cannot emit detached identity
* exposure requires valid backing identity
* migration is atomic and non-residual
