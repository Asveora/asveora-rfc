## 1. Purpose

This document defines the dependency relationships between all core Asveora schemas in the v1 canonical schema system under the **Path C architecture model (Schema / Decision / Runtime separation)**.

It ensures:

* deterministic schema validation ordering
* correct `$ref` resolution strategy
* strict separation of structural truth, decision models, and runtime enforcement
* elimination of circular authority assumptions
* alignment with Wheelcore execution semantics

---

## 2. Core Architectural Model (Path C)

The Asveora system is composed of **three distinct semantic tiers**:

---

### Tier 1 — Schema Layer (Structural Truth)

Schemas define:

* data structure
* invariants
* allowed forms of state
* identity and registry representation

Schemas DO NOT:

* enforce decisions
* execute logic
* mutate state
* produce runtime outcomes

> Schemas define what is valid, not what happens.

---

### Tier 2 — Decision Layer (Evaluation Models)

Decision schemas define:

* authorization rules (RBAC, delegation)
* governance policies (constraints, invariants)
* lifecycle state machines (transition rules)
* federation sync contracts (reconciliation semantics)

Decision layers DO NOT:

* enforce outcomes
* mutate registry or identity state
* override runtime behavior

> Decision layers define what should happen under evaluation.

---

### Tier 3 — Runtime Layer (Wheelcore Execution)

Wheelcore is responsible for:

* enforcement of decisions
* fail-closed execution
* state mutation
* suppression / emission control
* deployment and lifecycle activation

> Only Wheelcore executes outcomes.

---

## 3. Schema Dependency Layers (v1 → v2 normalized)

---

### Layer 0 — Identity Schema Layer (CIR)

#### Schema:

* `cir.schema.json` (AUIM canonical identity model)

#### Tier:

Schema Layer

#### Depends on:

NONE

#### Provides:

* identity structure (PIK, VSIG, APA, lifecycle state)
* deterministic identity representation

#### Constraint:

* MUST NOT embed decision logic
* MUST NOT imply enforcement behavior

---

### Layer 1 — Registry State Layer

#### Schema:

* `registry-state.schema.json`

#### Tier:

Schema Layer

#### Depends on:

* CIR (Layer 0)

#### Provides:

* deterministic projection of CIR set
* lifecycle grouping view
* registry snapshots

#### Constraint:

* MUST be derived only from CIR + commit history
* MUST NOT introduce classification logic
* MUST NOT enforce lifecycle transitions

---

### Layer 2 — Commit & Evolution Layer

#### Schemas:

* `registry-commit.schema.json`
* `commit-lifecycle.schema.json`

#### Tier:

Schema Layer (event representation only)

#### Depends on:

* CIR (Layer 0)
* Registry State (Layer 1)

#### Provides:

* append-only transition history
* state evolution records

#### Constraint:

* MUST NOT evaluate validity
* MUST NOT enforce transitions
* MUST NOT alter identity semantics

---

### Layer 3 — Authorization Decision Layer

#### Schemas:

* `role.schema.json`
* `permission.schema.json`
* `delegation.schema.json`
* `service-identities.schema.json`

#### Tier:

Decision Layer

#### Depends on:

* CIR (Layer 0)
* Registry State (Layer 1)

#### Provides:

* authorization evaluation rules
* access decision criteria (ALLOW / DENY / RESTRICT)

#### Constraint:

* MUST NOT enforce access
* MUST NOT mutate system state
* MUST NOT influence registry truth directly

> Produces decisions, not actions.

---

### Layer 4 — Federation Decision Layer

#### Schemas:

* `fdep.snapshot.schema.json`
* `fdep.delta.schema.json`
* `federation-sync-contract.schema.json`

#### Tier:

Decision Layer (transport + reconciliation semantics)

#### Depends on:

* CIR (Layer 0)
* Registry State (Layer 1)

#### Provides:

* synchronization contracts
* reconciliation candidates
* cross-instance state comparison format

#### Constraint:

* MUST NOT assert authority
* MUST NOT validate truth
* MUST NOT modify registry semantics

> Federation produces reconciliation inputs, not system truth.

---

### Layer 5 — Governance Decision Layer

#### Schemas:

* `governance-event.schema.json`
* `identity-state-machine.schema.json`
* `validation-pipeline.schema.json`

#### Tier:

Decision Layer (system policy definition only)

#### Depends on:

* CIR (Layer 0)
* Registry State (Layer 1)

#### Provides:

* lifecycle rule definitions
* validation pipeline definitions
* system constraint models

#### Constraint:

* MUST NOT enforce decisions
* MUST NOT override authorization or registry state

> Governance defines policy constraints, not execution.

---

### Layer 6 — API Contract Layer

#### Schemas:

* `api.schema.json`
* `query.schema.json`

#### Tier:

Schema Layer (external contract only)

#### Depends on:

* Registry State (Layer 1)
* Authorization Layer (Layer 3)
* Federation Layer (Layer 4)

#### Provides:

* external request/response structure
* validated output contracts

#### Constraint:

* MUST NOT perform evaluation
* MUST NOT compute decisions
* MUST only emit runtime results

---

## 4. Critical Dependency Rules (Path C Normalized)

---

### 4.1 No Upward Structural Referencing

Schemas MUST NOT reference:

* decision outcomes
* runtime enforcement results
* Wheelcore execution state
* inferred or evaluated system truth

---

### 4.2 CIR is the Structural Root

All identity and registry systems MUST trace to:

> CIR (AUIM canonical identity model)

No schema MAY bypass CIR as structural root.

---

### 4.3 Registry is Derived State Only

Registry:

* is derived from CIR
* is not an authority layer
* does not define identity truth

---

### 4.4 Commit Layer is Event History Only

Commit schemas:

* record transitions only
* MUST NOT validate or enforce transitions
* MUST NOT influence decision logic

---

### 4.5 Authorization is Decision-Only

Authorization schemas:

* produce evaluation outcomes only
* MUST NOT enforce or execute access control
* MUST NOT mutate system state

---

### 4.6 Governance is Policy-Only

Governance schemas:

* define constraints and rules only
* MUST NOT execute enforcement
* MUST NOT override other layers

---

## 5. Determinism Requirement

Given identical:

* CIR set
* commit history
* registry state snapshot

All schema evaluations MUST produce:

> identical structural and decision outputs across environments

---

## 6. Wheelcore Enforcement Boundary (NEW)

All enforcement is delegated to:

> Wheelcore Runtime Layer (Tier 3)

Wheelcore is responsible for:

* executing authorization decisions
* enforcing governance constraints
* applying federation reconciliation outcomes
* mutating registry state
* controlling API emission behavior

> Schemas and decision models are NEVER allowed to enforce behavior directly.

---

## 7. System Design Intent (Path C Final Form)

This architecture ensures:

* strict separation of structure, decision, and execution
* elimination of hidden enforcement in schemas
* deterministic validation and decision pipelines
* centralized enforcement in Wheelcore only
* fully transport-safe federation layer
* non-executing governance and authorization models

---

## 8. Summary

The v2 architecture is structured as:

* **CIR → Structural identity truth**
* **Registry → Derived structural projection**
* **Commit → Event history**
* **Authorization → Decision model**
* **Federation → Reconciliation model**
* **Governance → Policy model**
* **API → External contract layer**
* **Wheelcore → Execution & enforcement layer**
