## 1. Purpose

The Dependency Graph defines the structural, initialization, and enforcement ordering of all systems in the Asveora Core Architecture (Section 03), including both:

* RFC-defined systems (human-readable architecture)
* schema-defined systems (machine-enforceable rules)

This document is the **execution and initialization truth map** of Asveora.



## 2. Core Principle

All Asveora systems MUST obey dependency ordering.

This means:

* A system MUST NOT depend on an uninitialized system
* A system MUST NOT bypass declared dependency layers
* Dependency violations are treated as invalid system state

Additionally:

* RFC layers describe structure
* schemas define enforcement behavior
* schemas override RFC ambiguity when conflict exists



## 3. Dependency Types

### 3.1 Hard Dependency

* system cannot function without dependency
* initialization MUST fail if missing

### 3.2 Soft Dependency

* system can degrade gracefully
* partial functionality allowed

### 3.3 Context Dependency

* system may reference external data
* does NOT require initialization coupling



## 4. Global Architecture Dependency Chain



# Layer 0 — Identity Foundation Layer

* 03-02 Identity Core

### Contains:

* PIK
* APA
* AUID
* VSIG
* CIR primitives
* AER (includes non-authoritative RGBSIG layer)

### Depends on:

* None (root layer)

> **Note:** RGBSIG no longer exists as a standalone system. It is now encapsulated within AER, which is non-authoritative and strictly for expressive representation.



# Layer 1 — Network Instance Layer

* 03-03 Network Instance

### Depends on:

* Identity Core (Layer 0)

### Provides:

* instance sovereignty
* execution boundary
* runtime context



# Layer 2 — Validation Layer

* 03-05 Validation Architecture

### Depends on:

* Identity Core
* Network Instance

### Provides:

* CIR validation rules
* identity verification gates
* trust eligibility checks



# Layer 3 — Federation Layer

* 03-04 Federation

### Depends on:

* Network Instance
* Validation Layer

### Provides:

* FDEP protocol
* cross-instance communication
* synchronization channels



# Layer 4 — Registry Persistence Layer

* 03-06 Registry System

### Depends on:

* Identity Core
* Validation Layer

### Provides:

* CIR storage
* append-only identity registry
* registry commit lifecycle backbone



# Layer 5 — Authorization Schema Layer (NEW)

## THIS IS THE MAJOR UPDATE

This layer introduces schema-enforced authorization.

* rbac-model.schema.json
* permission-scopes.schema.json
* delegation.schema.json
* service-identities.schema.json

### Depends on:

* CIR (Identity Core state authority)
* Registry System
* Validation Layer

### Provides:

* RBAC model enforcement
* atomic permission evaluation
* delegation authority propagation rules
* service identity execution model
* Authorization Execution Pipeline (AEP foundation)

### Key Rule:

Schemas in this layer are **machine-enforceable truth sources**.



# Layer 6 — Access Control System (RFC Layer)

* 03-08 Access Control

### Depends on:

* Authorization Schema Layer (Layer 5)
* Registry System
* Identity Core
* Validation Layer
* Network Instance
* Federation Layer (contextual only)

### Provides:

* system-level authorization logic (RFC interpretation layer)
* human-readable enforcement semantics
* policy explanation layer

### Key Rule:

RFC access control MUST NOT contradict schema behavior.



# Layer 7 — API Layer

* 03-07 API Layer

### Depends on:

* Access Control System
* Registry System
* Identity Core

### Provides:

* identity resolution APIs
* CIR query interfaces
* external system access



# Layer 8 — Governance Layer

* 03-09 Governance Architecture

### Depends on:

* Access Control System
* Registry System
* Network Instance

### Provides:

* moderation
* policy enforcement
* governance actions



# Layer 9 — Lifecycle Layer

* 03-11 Identity Lifecycle and Onboarding

### Depends on:

* Validation Layer
* Registry System
* Access Control System

### Provides:

* identity state transitions
* onboarding flows
* lifecycle enforcement



# Layer 10 — Reserved Extension Layer

* 03-12 Reserved Future Specs

### Depends on:

* full system context (non-binding)



## 5. Cross-System Dependency Matrix (UPDATED)

| System                     | Depends On                                      | Type |
| -- | -- | - |
| Identity Core              | None                                            | Root |
| Network Instance           | Identity Core                                   | Hard |
| Validation                 | Identity + Instance                             | Hard |
| Federation                 | Instance + Validation                           | Hard |
| Registry                   | Identity + Validation                           | Hard |
| Authorization Schema Layer | CIR + Registry + Validation                     | Hard |
| Access Control (RFC)       | Schema Layer + Registry + Validation            | Hard |
| API Layer                  | Access Control + Registry + Identity            | Hard |
| Governance                 | Access Control + Registry                       | Hard |
| Lifecycle                  | Validation + Registry + Access Control          | Hard |
| AER (includes RGBSIG)      | Identity Core + AUID + VSIG (non-authoritative) | Soft |

> **Note:** AER depends on identity primitives but does not introduce authoritative state.



## 6. Critical Architectural Rules (UPDATED)

### 6.1 Schema Supremacy Rule

Schemas in Layer 5 are:

* executable truth definitions
* deterministic enforcement sources
* non-negotiable constraint systems

RFC cannot override schema behavior.



### 6.2 No Upstream Violation

Lower layers MUST NOT depend on higher layers.



### 6.3 Initialization Order

1. Identity Core
2. Network Instance
3. Validation Layer
4. Federation Layer
5. Registry System
6. Authorization Schema Layer
7. Access Control RFC Layer
8. API Layer
9. Governance Layer
10. Lifecycle Layer
11. AER (non-authoritative, runtime projection)



### 6.4 Circular Dependency Prohibition

* no circular initialization
* no recursive authorization loops
* no schema ↔ RFC dependency cycles



## 7. Federation Rule (UNCHANGED BUT CLARIFIED)

Federation:

* MAY influence context
* MUST NOT override local authorization
* MUST NOT override schema evaluation



## 8. Determinism Constraint

Given identical:

* CIR state
* schema state
* dependency graph state
* runtime input

System behavior MUST be identical across instances.



## 9. Design Intent (UPDATED)

This dependency graph ensures:

* strict separation of schema vs RFC responsibility
* deterministic authorization enforcement
* clean layering of identity → validation → registry → authorization
* federation remains non-authoritative
* AER remains isolated from authoritative computation
* system remains machine-verifiable at core layers



## 10. Summary

Asveora architecture is now structured as:

* Identity Core (foundation)
* Validation (truth verification)
* Registry (state persistence)
* Authorization Schema Layer (machine truth)
* Access Control RFC Layer (human interpretation)
* API / Governance / Lifecycle (operational layers)
* AER (runtime, non-authoritative expressive layer)
* Federation (contextual overlay only)



This version cleanly integrates AER while preserving all authoritative layer relationships and keeps the RGBSIG content encapsulated within it.
