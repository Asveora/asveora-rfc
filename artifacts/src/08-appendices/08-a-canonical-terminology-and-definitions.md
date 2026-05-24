## 1. Purpose

This document defines the canonical terminology used throughout the Asveora RFC.

It provides standardized definitions for identity, registry, federation, authorization, exposure, and lifecycle constructs.



## 2. Terminology Authority Rule

### Constraint

> Terminology in this section is descriptive only and MUST NOT override formal system definitions in Sections 3–7.

If conflicts occur:

* Sections 3–7 and schema definitions take precedence
* Section 8-A is treated as interpretive reference only



## 3. Core Identity Terminology

### 3.1 CIR — Core Identity Record

A CIR is the authoritative identity anchor within the Asveora system.

Properties:

* represents canonical identity state
* binds identity to registry truth
* serves as root reference for derived identity forms

Constraint:

> CIR is the primary identity truth source.



### 3.2 APC — Asveora Profile Core

APC is the structural identity representation composed of:

```text
[PIK]-[VSIG]
```

Where:

* PIK = Primary Identity Key
* VSIG = Verification Signature

Constraint:

> APC is a derived representation, not an authority source.



### 3.3 AUID — Asveora Unified Identity Descriptor

AUID is the composite identity descriptor composed of:

```text
[APA]=[PIK]-[VSIG]
```

Where:

* APA = Asveora Profile Address
* PIK = Primary Identity Key
* VSIG = Verification Signature

Constraint:

> AUID is a descriptive binding structure, not an identity authority.



### 3.4 PIK — Primary Identity Key

A unique identifier representing the root identity key within APC structures.

Properties:

* stable identity anchor
* registry-bound
* required for APC validity



### 3.5 VSIG — Verification Signature

A cryptographic or validation-derived signature confirming identity integrity.

Properties:

* ensures identity authenticity
* binds APC structure to verification layer
* required for identity validation



### 3.6 APA — Asveora Profile Address

A locational or contextual identity reference used in AUID structures.

Properties:

* represents identity namespace or address context
* does not define identity authority
* used for structural resolution only



## 4. Registry Terminology

### 4.1 Registry

The authoritative persistence layer for identity and system state.

Properties:

* single source of truth for identity validity
* enforces lifecycle consistency
* governs state transitions



### 4.2 Registry Entry

A structured record within the registry containing:

* identity references (CIR/APC/AUID)
* lifecycle state
* authorization bindings
* federation metadata



### 4.3 Registry State

The current authoritative snapshot of all valid system entries.

Constraint:

> Registry state is the only valid source of truth for identity resolution.



## 5. Federation Terminology

### 5.1 Federation

A distributed synchronization layer for registry-consistent state propagation.

Properties:

* non-authoritative
* synchronization-only role
* consistency enforcement dependent



### 5.2 Node

An individual execution instance participating in federation.

Properties:

* holds local registry replica
* enforces local validation rules
* does not define global truth



### 5.3 Divergence

A state condition where nodes disagree on registry or identity state.

Constraint:

> Divergence MUST trigger restriction or suppression, never authority override.



## 6. Authorization Terminology

### 6.1 RBAC — Role-Based Access Control

A permission model based on assigned roles.

Properties:

* explicit permission mapping
* no implicit privilege inheritance



### 6.2 Delegation

A controlled transfer of authority between entities.

Properties:

* bounded scope
* verifiable chain
* registry-validated



### 6.3 Service Identity

A non-human identity used for system-level operations.

Constraint:

> Service identities MUST be registry-bound and explicitly authorized.



## 7. Exposure Terminology

### 7.1 EDS — Exposure Decision System

A deterministic filtering system that determines what data MAY be externally exposed.

Properties:

* evaluates identity + authorization + registry state
* enforces suppression rules
* prevents reconstruction attacks



### 7.2 Suppression

A state where output is intentionally withheld from emission.



### 7.3 Reconstruction Risk

A condition where emitted data could be used to infer hidden identity or system state.

Constraint:

> Reconstruction risk MUST trigger suppression.



## 8. Lifecycle Terminology

### 8.1 Migration

A controlled transition between system states.

Properties:

* atomic operation
* registry-backed
* fail-closed enforced



### 8.2 Lifecycle State

The current operational phase of an identity or system entity.

Examples:

* active
* revoked
* migrating
* invalidated



### 8.3 Revocation

A permanent invalidation of identity or registry entry.

Constraint:

> Revocation MUST propagate across all dependent system layers.



## 9. System Execution Terminology

### 9.1 Deterministic Execution

A system property where identical inputs produce identical outputs.



### 9.2 Fail-Closed

A security model where uncertainty results in denial or suppression.



### 9.3 Emission

The final output phase of the API layer after all validation and filtering.



## 10. Architectural Terminology

### 10.1 Wheelcore

The deterministic runtime execution substrate for Asveora systems.



### 10.2 Layer Model

A hierarchical system structure defining separation of concerns across:

* identity
* registry
* federation
* authorization
* exposure
* API
* governance
* lifecycle



## 11. Consistency Constraint

All terminology MUST remain consistent with:

* schema definitions
* registry rules
* exposure model
* security model
* implementation guidelines
