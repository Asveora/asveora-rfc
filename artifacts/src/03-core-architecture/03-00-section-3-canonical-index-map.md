# 3.0 Section 3 Canonical Index Map (RFC ↔ Schema ↔ Filesystem Alignment)

This document defines the authoritative mapping between:

- Section 3 RFC documents
- Schema definitions
- Filesystem structure
- Dependency graph execution layers

It serves as the deterministic resolution layer for all Section 3 structural interpretation.

This document is derived from the Section 3 Canonical Lock and is its operational companion.



## 3.0.1 Purpose

The purpose of this index map is to:

* provide a complete cross-reference of Section 3 systems
* eliminate ambiguity between RFC numbering and filesystem structure
* align schemas with RFC modules
* define execution dependency relationships
* ensure deterministic system reconstruction from any single artifact set



## 3.0.2 System Mapping Overview

Section 3 is composed of four synchronized layers:

1. **RFC Documents (human architecture definition)**
2. **Schema Definitions (machine constraints)**
3. **Filesystem Structure (physical truth)**
4. **Dependency Graph (execution ordering model)**

> All four MUST remain consistent for system correctness.



## 3.0.3 Core Architecture Index

| RFC File | System Name | Schema Dependencies | Execution Layer |
|-|||--|
| 03-00-dependency-graph.md | Dependency Graph | dependency-graph.schema.json | Layer ordering model |
| 03-01-overview.md | System Overview | none | Layer 0 |
| 03-03-network-instance.md | Network Instance | cir.schema.json, registry-state.schema.json | Layer 1 |
| 03-04-federation | Federation Model | fdep.* schemas | Layer 2 |
| 03-05-validation-architecture.md | Validation Architecture | validation-pipeline.schema.json | Layer 2 |
| 03-06-registry-system.md | Registry System | registry-state.schema.json, registry-commit.schema.json | Layer 1 |
| 03-07-api-layer.md | API Layer | api contracts | Layer 3 |
| 03-10-federation-trust-reputation-model.md | Trust Model | federation + governance schemas | Layer 2 |
| 03-11-identity-lifecycle-and-onboarding.md | Identity Lifecycle | identity-state-machine.schema.json | Layer 2 |
| 03-12-governance-architecture.md | Governance | governance-event.schema.json | Layer 2 |
| 03-13-reserved-future-specs.md | Reserved Extensions | none | N/A |



## 3.0.4 Identity Subsystem Mapping (03-02)

| Component | Schema | Role |
|-|--||
| PIK | pik.schema.json | Identity anchor |
| APA | apa.schema.json | Identity locator |
| RGBSIG | rgbsig.schema.json | Presentation metadata |
| AUID | derived identity model | global identity reference |
| Instance Boundary | conceptual model | runtime isolation boundary |

> Identity subsystem is PURE structural truth and must NOT contain execution logic.



## 3.0.5 Federation Subsystem Mapping (03-04)

| Component | Schema | Role |
|-|--||
| FDEP | fdep.snapshot / delta | federation transport protocol |
| Sync Model | federation-sync-contract.schema.json | reconciliation rules |
| Topology | conceptual model | instance connectivity structure |

> Federation defines communication, not authority.



## 3.0.6 Access Control Subsystem Mapping (03-08)

| Component | Schema | Role |
|-|--||
| RBAC Model | rbac-model.schema.json | role structure |
| Permissions | permission-scopes.schema.json | action constraints |
| Delegation | delegation.schema.json | authority propagation |
| Service Identity | service-identity.schema.json | machine actors |
| Execution Pipeline | authorization-execution-pipeline.md | evaluation ordering |

> Access control is decision logic only; execution is external.



## 3.0.7 Schema Dependency Alignment Rules

All schemas MUST obey:

### Rule 1 — CIR Root Authority
All identity-related schemas MUST derive from CIR structure.

### Rule 2 — Registry Derivation
Registry schemas MUST be derived from CIR state ONLY.

### Rule 3 — No Cross-Tier Enforcement
Schemas MAY NOT enforce runtime behavior.

### Rule 4 — Federation Isolation
Federation schemas MUST NOT override local CIR truth.



## 3.0.8 Execution Layer Alignment

| Layer | Responsibility |
||-|
| Layer 0 | Identity primitives |
| Layer 1 | Network Instance + Registry |
| Layer 2 | Validation, Federation, Governance decisions |
| Layer 3 | API + Runtime exposure |
| Layer 4 | Reserved |
| Layer 5 | Schema enforcement boundary |
| Layer 6+ | Future extensions |



## 3.0.9 Stub File Interpretation

Any file previously marked as:

- 0 KB
- empty
- placeholder

MUST be treated as:

> structural intent without finalized specification

They are NOT deleted or invalid.

They are pending canonical resolution.



## 3.0.10 Deterministic Reconstruction Rule

Given:

- schema set
- RFC set
- dependency graph

The system MUST be reconstructible without ambiguity using this map.

If reconstruction fails, this document is incomplete or inconsistent.



## 3.0.11 Relationship to Section 3 Canonical Lock

This document:

- operationalizes the lock file
- maps abstract rules to concrete structures
- ensures cross-reference determinism

Together they form:

> Section 3 Structural Authority System



## 3.0.12 Summary

This index map ensures:

- every RFC maps to a schema context
- every schema maps to an execution layer
- every subsystem is traceable
- no hidden structural ambiguity exists

It is the canonical bridge between design, schema enforcement, and runtime interpretation.