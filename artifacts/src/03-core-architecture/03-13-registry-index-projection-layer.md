# 3.15.1 Registry Index Projection Layer (Search & Resolution States)

The Registry Index Projection Layer defines the deterministic system responsible for translating CIR-backed identity state and validation outcomes into human-readable search results and registry index views within the Asveora ecosystem.

It operates as a **read-only interpretation layer** that sits above CIR and Validation Architecture, and below UI rendering systems.

The Projection Layer does not store identity state. It derives meaning from authoritative sources.



## 3.15.2 Purpose

The Registry Index Projection Layer exists to:

* translate CIR identity state into human-readable search results
* represent identity resolution outcomes in registry indexes
* communicate lookup failures and federation lag conditions
* expose transport-bound identity states (e.g., Matrix-only identities)
* standardize how identity visibility is represented across Network Instances

It answers:

> “What does the registry show when this identity is queried?”



## 3.15.3 Architectural Role

The Projection Layer is:

> a deterministic interpretation and rendering layer for identity resolution results

It is NOT:

* a registry system (CIR owns that role)
* a validation system (3.5 owns that role)
* a lifecycle system (3.11 owns that role)
* a federation trust system (3.10 owns that role)

It functions strictly as a **query-time transformation layer**.



## 3.15.4 Input Dependencies

The Projection Layer derives state from:

* CIR (Canonical Identity Record state)
* Validation Architecture outputs (3.5)
* Federation propagation status (3.10)
* Transport binding resolution (Matrix / APA / Profile Space availability)

No independent state is stored or mutated.



## 3.15.5 Output Model

All registry index queries MUST resolve into one of the following projection states:

| State            | Meaning                                                    |
| - | - |
| ACTIVE           | Identity is fully resolved and usable within CIR           |
| SUSPENDED        | Identity exists but is restricted from full participation  |
| MIGRATING        | Identity is undergoing cross-instance transition           |
| TOMBSTONED       | Identity is permanently retired and non-active             |
| UNKNOWN          | Identity lookup failed or CIR record could not be resolved |
| [MATRIX ADDRESS] | Identity exists only within Matrix transport layer context |



## 3.15.6 State Definitions

### ACTIVE

Identity is fully resolved and present in CIR as ACTIVE.

* CIR record exists
* identity_state = ACTIVE
* fully usable within the network instance



### SUSPENDED

Identity exists in CIR but is temporarily restricted.

* CIR record exists
* identity_state = SUSPENDED
* may have limited visibility or interaction permissions



### MIGRATING

Identity is in active transition between Network Instances.

* CIR record exists
* federation migration is in progress
* state is stable but transitional



### TOMBSTONED

Identity is permanently retired.

* CIR record exists
* identity_state = TOMBSTONED
* must not be treated as active in any system



### UNKNOWN (LOOKUP / PROJECTION FAILURE STATE)

UNKNOWN represents a **registry resolution failure condition**.

It indicates that:

* no CIR record was found for the requested identity, OR
* CIR lookup failed due to synchronization delay, OR
* federation propagation has not yet completed, OR
* index state is temporarily inconsistent

IMPORTANT:

> UNKNOWN is NOT a lifecycle state and MUST NOT be treated as identity existence or validity.

It is strictly a:

> **query-time resolution failure or incomplete projection state**



### [MATRIX ADDRESS] (TRANSPORT PLACEHOLDER STATE)

This state indicates that an identity is currently bound only to the Matrix transport layer and has not yet completed full Asveora registry resolution.

It communicates:

> “This identity only lives in the Matrix ecosystem at this time.”

Characteristics:

* identity is in onboarding or verification stage
* CIR entry may be incomplete or uncommitted
* APA / Profile Space binding is not yet resolved
* identity is accessible only through Matrix-based verification channels

This is a **transport-level visibility state**, not a lifecycle state.



## 3.15.7 Deterministic Derivation Rules

Projection states MUST be derived deterministically using:

1. CIR identity_state
2. Validation Architecture results (3.5)
3. Federation synchronization status (3.10)
4. Transport binding resolution status

No manual assignment or heuristic classification is permitted.

Given identical inputs, the projection output MUST always be identical.



## 3.15.8 Separation of Concerns

The Projection Layer explicitly enforces the following boundaries:

* CIR defines identity truth
* Validation defines correctness
* Federation defines trust and propagation
* Lifecycle defines state transitions
* Projection defines human-readable interpretation

Projection MUST NOT:

* modify CIR state
* influence lifecycle transitions
* override validation results
* enforce federation decisions



## 3.15.9 Federation Awareness

The Projection Layer MAY reflect federation propagation delay as UNKNOWN.

However:

* federation does NOT define projection rules
* federation does NOT assign projection states
* projection must remain deterministic regardless of network instance delays



## 3.15.10 Security Model

The Projection Layer is read-only and non-authoritative.

It protects against:

* misinterpretation of missing CIR records as valid identities
* premature trust assignment to unregistered identities
* transport-layer spoofing of identity existence
* federation lag being misinterpreted as identity loss

All security decisions MUST be handled by Validation Architecture (3.5), not projection logic.



## 3.15.11 Failure Handling

If CIR or validation data cannot be retrieved:

* output MUST default to UNKNOWN
* no partial identity state MAY be exposed as ACTIVE
* no inferred lifecycle state MAY be produced

Failure is represented as a projection state, not an identity mutation.



## 3.15.12 Relationship to Other Systems

### Depends on:

* 3.5 Validation Architecture
* 3.9 CIR (Canonical Identity Record)
* 3.10 Federation Trust Model
* 3.11 Identity Lifecycle & Onboarding

### Feeds into:

* UI rendering systems (HTML Profile Space, registry index views)
* administrative dashboards
* search and discovery interfaces
* onboarding verification views



## 3.15.13 Summary

The Registry Index Projection Layer provides a deterministic, read-only interpretation system for identity resolution within Asveora.

It ensures:

* clear distinction between identity existence and lookup failure
* explicit communication of Matrix-only transport-bound identities
* consistent human-readable interpretation of CIR-backed truth
* strict separation between authoritative state and UI representation

Projection is not truth. It is the structured reflection of truth under query conditions.
