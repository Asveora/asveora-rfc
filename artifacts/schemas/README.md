## Asveora Schema System Overview

This directory contains the machine-enforceable schema definitions for the Asveora RFC architecture. These schemas define the deterministic structure of core identity, registry, and federation components.

All schemas in this directory are **normative at the data level**, meaning:

* They define structure, constraints, and validation rules
* They do NOT define runtime behavior or policy interpretation
* They MUST be treated as authoritative for implementation consistency

---

## Schema Authority Hierarchy

The Asveora schema system follows a strict hierarchy of structural dependency:

---

## 1. CIR (Canonical Identity Record — AUIM Compliant)

**Highest identity structural layer**

* CIR is defined under the Asveora Unified Identity Model (AUIM) and represents the canonical identity structure used across all system layers.
* Defines the canonical truth of an identity
* Controls lifecycle state (`identity_state`)
* Represents the authoritative identity object within a Network Instance

CIR is the **source of structural identity truth**.

---

## 2. Registry State Schema

**System-level deterministic projection layer**

* Defines a snapshot view of all CIRs within a Network Instance
* Groups identities by derived lifecycle state
* Provides observability and operational metadata

Registry State is a **derived projection of CIR data**, not an independent truth source.

It MUST NOT introduce classification or authority semantics beyond `CIR.identity_state`.

---

## 3. Commit Lifecycle Schema (deterministic execution model)

**Process + validation execution layer (non-authoritative)**

* Defines how CIRs transition into the registry
* Defines validation stages and commit rules
* Defines deterministic evaluation pipeline for registry inclusion
* Does NOT define identity truth

Commit Lifecycle is a **deterministic execution and validation model, not a policy or governance system**.

---

# ## Critical Derivation Rules

---

## Rule 1: CIR is the only source of identity truth

All identity state MUST be derived from CIR:

* `identity_state` inside CIR is canonical
* Registry grouping is derived
* No external system MAY override CIR identity state

---

## Rule 2: Registry State is a deterministic projection

Registry State MUST:

* Be computed exclusively from CIR data
* Never define or mutate identity truth
* Never introduce independent identity classification logic

Registry State is a **read model only**.

---

## Rule 3: No bidirectional authority flow

The following is strictly prohibited:

* Registry State influencing CIR state
* Federation metadata modifying CIR identity state
* Lifecycle metadata overriding CIR fields

Data flow MUST be unidirectional:

```
CIR → Registry State → External Observability
```

---

## Rule 4: Federation data is non-authoritative

Any federation-related fields in schemas:

* MUST be treated as advisory only
* MUST NOT override CIR or registry logic
* MUST NOT affect identity validity or lifecycle state
* Federation schemas (`fdep.snapshot`, `fdep.delta`) are transport-only and MUST NOT influence CIR validation, registry construction, or lifecycle transitions

Examples:

* `trust_hint`
* `sync_state`
* `federation_origin`

---

## Rule 5: Deterministic system requirement

Given identical CIR inputs, all compliant implementations MUST produce:

* identical registry-state outputs
* identical grouping behavior
* identical identity counts

Non-deterministic schema interpretation is non-compliant.

---

# ## Schema Separation Principles

---

## Identity Layer (CIR)

Defines:

* identity existence
* lifecycle state
* verification binding (VSIG)
* optional presentation metadata (RGBSIG — non-authoritative)

> RGBSIG is a human-only activity proof artifact and MUST NOT be used in identity resolution, verification, or registry logic.

---

## System Layer (Registry State)

Defines:

* aggregation of identities
* operational snapshots
* system-level metadata
* observability structures

---

## Process Layer (Commit Lifecycle)

Defines:

* how CIR enters the registry
* deterministic validation sequencing
* commit evaluation pipeline
* registry inclusion eligibility checks

It does NOT define identity truth or policy behavior.

---

# ## Boundary Constraints

Schemas MUST respect strict separation:

| Concern               | Allowed Location            |
| --------------------- | --------------------------- |
| Identity truth        | CIR only                    |
| Identity grouping     | Registry State              |
| Lifecycle transitions | CIR (`identity_state` only) |
| Commit evaluation     | Commit Lifecycle            |
| Federation transport  | Federation schemas only     |
| Presentation (RGBSIG) | CIR only, non-authoritative |

---

# ## Versioning & Stability Rules

* Schemas are versioned independently of RFC text sections
* Breaking schema changes MUST NOT occur without:

  * explicit RFC revision
  * compatibility mapping strategy
* CIR schema changes are considered **high-impact architectural changes**

---

# ## Implementation Guidance

Implementers MUST:

* Validate CIR before registry inclusion
* Treat registry-state as a derived read model
* Ignore federation metadata for identity validity
* Enforce deterministic projection rules
* Maintain append-only identity history consistency

Implementers MUST NOT:

* Use registry-state as a source of identity truth
* Mutate CIR based on registry aggregation
* Infer identity validity from federation trust signals

---

# ## Design Intent

The schema system exists to:

* enforce deterministic identity truth (CIR)
* provide scalable observability (Registry State)
* support controlled identity onboarding (Commit Lifecycle)
* preserve federation neutrality (transport-only model)
* maintain strict separation of concerns
* prevent hidden authority or control-plane behavior in schema definitions

---

# ## Summary

The Asveora schema system enforces a strict architectural contract:

* CIR defines identity truth
* Registry State reflects a deterministic projection of that truth
* Commit Lifecycle governs validation execution before registry inclusion

No schema in this directory is permitted to override or redefine identity validity outside its designated responsibility boundary.
