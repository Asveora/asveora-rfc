## 3.9.1 Registry System (CIR)

The Registry System in Asveora is implemented through the Canonical Identity Record (CIR), which serves as the authoritative storage and validation authority for identity state within a Network Instance.

The CIR is the single source of truth for identity existence, lifecycle state, reservation state, and verification integrity. It is the final authority for determining whether an identity primitive is valid.

## 3.9.2 Purpose

The Registry System exists to:

* maintain authoritative identity records
* enforce uniqueness of identity primitives
* track identity lifecycle state
* validate identity authenticity
* manage candidate PIK reservation and collision resolution
* support federation-safe identity reconciliation

It answers the question:

> “What identities exist, and what is their authoritative state?”

## 3.9.3 Architectural Role

The CIR is:

> the authoritative identity registry layer within a Network Instance

It is responsible for:

* identity persistence
* identity validation state
* lifecycle enforcement
* tombstoning control
* migration reconciliation support
* candidate identity reservation and conflict resolution

The CIR is authoritative only within its local Network Instance boundary.

## 3.9.4 Registry Scope

Each Network Instance maintains its own CIR.

This means:

* there is no global centralized registry
* identity authority is distributed
* each instance enforces its own validation state
* federation coordinates, but does not centralize registry authority

Registry scope is strictly local to each instance.

## 3.9.5 Candidate PIK Model (NEW)

The CIR supports **user-submitted candidate PIKs** as part of the identity onboarding process.

A PIK MAY exist in one of the following registry phases:

| Phase     | Meaning                              |
| --------- | ------------------------------------ |
| CANDIDATE | Submitted by user, not yet evaluated |
| RESERVED  | Approved by CIR, temporarily locked  |
| COMMITTED | Fully registered identity primitive  |
| REJECTED  | Collision or invalidity detected     |

Rules:

* Users MAY submit a PIK proposal (manual or generated)
* CIR MUST evaluate all candidate PIKs for:

  * structural validity
  * uniqueness
  * collision against existing registry entries
* CIR MUST reject any PIK that collides with an existing entry
* CIR MUST NOT allow duplicate reservation states

Constraint:

> A PIK is not authoritative until it reaches RESERVED or COMMITTED state.

## 3.9.6 Stored Identity Primitives

The CIR is responsible for managing the authoritative state of:

| Primitive | Role                                                                |
| --------- | ------------------------------------------------------------------- |
| PIK       | Persistent identity anchor (including reservation lifecycle state)  |
| VSIG      | Verification signature state                                        |
| APC       | Authoritative identity core                                         |
| AUID      | Resolvable identity representation                                  |
| AER       | Expressive identity representation (metadata ignored in validation) |

The CIR does not store presentation authority; it stores validation-relevant state.

## 3.9.7 Identity Lifecycle Management

The CIR manages the lifecycle of all identity records.

### Lifecycle States

| State       | Meaning                                         |
| ----------- | ----------------------------------------------- |
| Active      | Identity is valid and usable                    |
| Migrating   | Identity is in transition between instances     |
| Tombstoned  | Identity is permanently retired                 |
| Invalidated | Identity has failed validation integrity checks |

Lifecycle state is authoritative and enforced by the CIR.

## 3.9.8 Validation Authority

The CIR is the source of truth for validation systems.

All identity validation MUST:

* query CIR state
* verify PIK existence and reservation status
* validate VSIG integrity
* confirm lifecycle state
* enforce tombstoning rules

If CIR validation fails, the identity is invalid regardless of external representation.

## 3.9.9 Uniqueness Enforcement

The CIR enforces uniqueness constraints on:

* PIK values (including candidate phase collision detection)
* identity records
* active identity bindings

This ensures:

* no duplicate authoritative identities exist within a Network Instance
* no duplicate PIK reservations can occur
* identity collisions are resolved deterministically at registry level
* federation synchronization remains consistent

Uniqueness is a hard constraint enforced by the registry.

## 3.9.10 Relationship to APC

The CIR validates the:

> APC (Authoritative Profile Core)

Canonical structure:

```
[PIK]-[VSIG]
```

The CIR ensures:

* PIK is registered and in valid state (RESERVED or COMMITTED)
* VSIG is cryptographically or structurally verified (implementation-dependent)
* APC integrity is consistent with registry state

The APC is the primary validation target of the CIR.

## 3.9.11 Relationship to AUID and AER

The CIR does not validate presentation metadata.

### AUID

```
[APA]=[PIK]-[VSIG]
```

The CIR validates the APC portion only.

### AER

```
[APA]=[PIK]-[VSIG]:[RGBSIG]
```

The CIR:

* validates the left-side AUID portion
* explicitly ignores RGBSIG during validation

Presentation metadata is outside registry authority.

## 3.9.12 Federation Interaction

The CIR participates in federation systems through controlled synchronization mechanisms.

Federation MAY:

* propagate identity lifecycle updates
* request validation state reconciliation
* synchronize migration events

However:

* CIR state MUST remain locally authoritative
* federation MUST NOT directly mutate CIR records
* external instances MUST NOT override registry decisions

Each CIR remains sovereign.

## 3.9.13 Migration Support

The CIR supports identity migration between Network Instances.

During migration:

* identity state is temporarily marked as Migrating
* validation state is preserved during transfer
* tombstoning rules remain enforced
* PIK integrity MUST remain unchanged

Migration is a state transition, not identity recreation.

## 3.9.14 Tombstoning Behavior

When an identity is tombstoned:

* it is permanently marked as non-reusable
* its PIK is reserved and cannot be reassigned
* historical reference MAY remain accessible
* validation systems MUST reject active usage

Tombstoning ensures long-term identity integrity.

## 3.9.15 Security Model

The CIR is a high-trust system component.

Therefore:

* all writes MUST be validated
* candidate PIK submissions MUST undergo collision checks
* identity mutations MUST be controlled
* lifecycle transitions MUST be deterministic
* unauthorized modification MUST be impossible under compliant implementations

The CIR is the enforcement boundary for identity integrity.

## 3.9.16 Deterministic State Principle

The CIR MUST behave deterministically.

This means:

* identical inputs MUST produce identical registry state outcomes
* validation results MUST be consistent across systems
* lifecycle transitions MUST follow defined rules
* federation synchronization MUST not alter correctness

Determinism is required for federation consistency.

## 3.9.17 Relationship to Other Systems

The CIR directly interacts with:

* PIK (identity anchor + reservation lifecycle)
* VSIG (verification layer)
* APC (identity core)
* AUID (resolvable identity)
* AER (expressive identity representation)
* Federation systems (coordination only)
* Validation architecture (consumers of CIR state)

The CIR is the authoritative registry foundation of the Asveora ecosystem.

## 3.9.18 Summary

The Registry System (CIR) is the authoritative identity state manager within each Network Instance.

It provides:

* deterministic identity storage
* candidate PIK reservation and collision resolution
* lifecycle state management
* validation authority
* uniqueness enforcement
* federation-safe synchronization support
* strict separation from presentation metadata

The CIR is the foundational truth source for all identity validation within the Asveora ecosystem.
