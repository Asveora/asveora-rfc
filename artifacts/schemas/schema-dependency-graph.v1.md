## 1. Purpose

This document defines the **dependency relationships between all core Asveora schemas** in the v1 canonical schema system.

It exists to ensure:

* deterministic schema validation ordering
* correct `$ref` resolution strategy
* clear separation of foundational vs derived schemas
* prevention of circular schema dependencies
* alignment with runtime and registry dependency rules

---

## 2. Core Principle

Schemas in Asveora MUST follow a strict **bottom-up dependency hierarchy**:

> foundational schemas define structural truth → higher schemas compose or project that truth

A schema MUST NOT depend on:

* higher-layer composite schemas for truth definition
* runtime-only constructs
* presentation-layer data
* policy-driven or interpretation-based outputs

---

## 3. Schema Dependency Layers (v1)

---

### Layer 0 — Primitive Identity Schema Layer

#### Schema:

* `cir.schema.json` (AUIM-compliant identity model)

#### Description:

The root structural truth of identity in Asveora.
Defines canonical identity representation only.

#### Dependencies:

* NONE

#### Provides:

* identity primitives (PIK, APA, VSIG, lifecycle state)
* deterministic identity structure

---

### Layer 1 — Registry State Layer

#### Schema:

* `registry-state.schema.json`

#### Depends on:

* `cir.schema.json` (AUIM canonical identity model)

#### Provides:

* deterministic projection of CIR set
* lifecycle partitioning view (ACTIVE/SUSPENDED/TOMBSTONED/MIGRATING)
* commit-linked registry snapshots

#### Constraint:

* MUST be fully derived from CIR set + commit history only
* MUST NOT introduce independent classification logic
* MUST NOT override CIR.identity_state

---

### Layer 2 — Commit & State Evolution Layer

#### Schemas:

* `registry-commit.schema.json`
* `commit-lifecycle.schema.json`

#### Depends on:

* CIR (Layer 0)
* Registry State (Layer 1)

#### Provides:

* append-only state transition history
* deterministic mutation tracking
* registry evolution chain

#### Constraint:

* MUST NOT define identity truth
* MUST NOT reinterpret CIR state
* MUST only record transitions and validation outcomes

---

### Layer 3 — Authorization Schema Layer

#### Schemas:

* `role.schema.json`
* `permission.schema.json`
* `delegation.schema.json`
* `service-identities.schema.json`

#### Depends on:

* CIR (Layer 0)
* Registry State (Layer 1)

#### Provides:

* permission mapping model (RBAC)
* delegation constraints (scoped permission forwarding only)
* service identity execution bindings

#### Critical Constraint (NEW HARDENED RULE):

> Authorization schemas MUST NOT influence CIR state, registry state, federation behavior, or validation pipelines.

They are strictly:

> permission evaluation inputs, not system control mechanisms

---

### Layer 4 — Federation Schema Layer

#### Schemas:

* `fdep.snapshot.schema.json`
* `fdep.delta.schema.json`
* `federation-sync-contract.schema.json`

#### Depends on:

* CIR (Layer 0)
* Registry State (Layer 1)

#### Provides:

* cross-instance CIR transport
* deterministic snapshot + delta synchronization

#### Critical Constraint (HARDENED):

* MUST be transport-only
* MUST NOT contain trust logic
* MUST NOT infer identity validity
* MUST NOT alter registry semantics

---

### Layer 5 — Governance & Lifecycle Schema Layer

#### Schemas:

* `governance-event.schema.json`
* `identity-state-machine.schema.json`
* `validation-pipeline.schema.json`

#### Depends on:

* CIR (Layer 0)
* Registry State (Layer 1)

#### Provides:

* deterministic lifecycle definition (state machine)
* validation execution pipeline definition
* audit-only governance event logging

#### Critical Constraint (UPDATED):

> Governance is strictly observational and declarative. It MUST NOT perform enforcement, override authorization, or modify registry or CIR state.

---

### Layer 6 — API & External Contract Layer

#### Schemas:

* `api.schema.json`
* `query.schema.json`

#### Depends on:

* Registry State (Layer 1)
* Authorization Layer (Layer 3)
* Federation Layer (Layer 4)

#### Provides:

* external system contracts
* query validation schemas
* API boundary definitions

---

## 3.1 Identity Representation Boundary Contract (NEW)

This system defines two strictly separated CIR representations:

### 3.1.1 Authoritative CIR (Registry Form)

* Full CIR object as defined in `cir.schema.json`
* Stored exclusively in registry-state layer
* Contains complete identity lifecycle state

### 3.1.2 Federation CIR (Transport Projection)

Used in:

* `federation-sync-contract.schema.json`
* `fdep.snapshot.schema.json`
* `fdep.delta.schema.json`

Properties:

* MUST be a **loss-reduced projection of CIR**
* MAY contain references instead of full structural objects
* MUST NOT include registry-internal metadata beyond identity_state + required references
* MUST NOT be interpreted as authoritative identity truth

### Constraint

> Federation CIR is a transport-safe projection ONLY and MUST NOT be treated as registry-equivalent structure.

---

## 4. Critical Dependency Rules

---

### 4.1 No Upward Schema Referencing

A schema MUST NOT reference:

* higher-layer schemas
* runtime-derived views
* policy evaluation outputs
* trust-scored or interpreted data

---

### 4.2 CIR is the Universal Root

All schema systems MUST ultimately trace back to:

> `cir.schema.json` (AUIM canonical identity model)

No schema is allowed to bypass CIR as structural root truth.

---

### 4.3 Registry is the First Composite Layer

Registry State:

* is the first derived projection layer
* introduces grouping semantics only
* MUST NOT redefine identity truth

---

### 4.4 Commit Layer is Evolutionary Only

Commit schemas:

* record transitions only
* MUST NOT alter identity semantics
* MUST NOT influence validation outcomes

---

### 4.5 Authorization is Non-Authority Binding

Authorization schemas:

* define permission constraints only
* MUST NOT control system behavior
* MUST NOT influence federation or registry state

---

### 4.6 Governance is Audit-Only (NEW HARDENING)

Governance schemas:

* record intent only
* MUST NOT execute or enforce decisions
* MUST NOT override any system layer

---

## 5. Determinism Requirement

Given identical:

* CIR set
* commit history
* registry state snapshot

Schema validation MUST produce:

> identical results across all environments

No schema layer is permitted to introduce nondeterministic interpretation.

---

## 6. Schema System Design Intent

This architecture ensures:

* deterministic validation pipelines
* reproducible registry reconstruction
* strict separation of identity vs authorization
* fully transport-isolated federation layer
* audit-only governance model
* prevention of hidden control planes in schema definitions

---

## 7. Summary

The v1 schema architecture is structured as:

* CIR → root identity truth (AUIM)
* Registry → deterministic state projection
* Commit layer → append-only evolution history
* Authorization → scoped permission evaluation only
* Federation → transport layer only
* Governance → audit-only event recording
* API → external contract boundary layer