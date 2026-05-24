## 3.11.3 Delegation Model (Authority Propagation Layer)

Delegation defines how authority and permission scope subsets can be temporarily or conditionally extended from one identity to another within the Asveora system.

All delegation behavior is defined by the schema:

/schemas/access-control/delegation.schema.json

## Core Purpose

Delegation exists to:

* allow controlled transfer of authorization capability
* enable constrained trust propagation between identities
* support temporary or conditional authority extension

Delegation does NOT create new permissions — it only propagates existing ones under strict constraints.

## Schema Authority Rule

All delegation behavior MUST be derived from schema definitions.

The authoritative schema is:

/schemas/access-control/delegation.schema.json

This document provides interpretation and system-level constraints only.

## Delegation Structure

A delegation consists of:

* delegation_id (unique identifier)
* from_identity (source CIR-backed identity)
* to_identity (target CIR-backed identity)
* permissions (subset of scoped permissions)
* delegation_type (TEMPORARY, CONDITIONAL, PERMANENT)
* constraints (governing rules)
* optional expiration (expires_at)

## Core Constraints

Delegation MUST:

* originate from a valid CIR-backed identity
* target a valid CIR-backed identity
* explicitly enumerate delegated permissions
* respect RBAC and permission scope rules

Delegation MUST NOT:

* override CIR identity state
* bypass RBAC evaluation
* introduce new permissions outside defined scopes
* grant global or system-level authority implicitly

## Delegation Types

### TEMPORARY

* time-bound authority transfer
* expires automatically at expires_at

### CONDITIONAL

* active only under defined constraints
* evaluated at runtime deterministically

### PERMANENT

* persistent delegation relationship
* still subject to revocation via CIR or governance systems

## Evaluation Order

Delegation is evaluated AFTER:

1. CIR identity validation
2. RBAC role resolution
3. Permission scope aggregation

Then:

4. delegation constraints are evaluated
5. delegated permissions are merged into evaluation context
6. final authorization decision is computed



## Constraint Model

Delegation constraints MAY include:

* time windows
* identity state requirements (ACTIVE, MIGRATING, etc.)
* resource-specific restrictions
* environment-bound execution rules

Constraints MUST remain deterministic and schema-defined.

Constraints MUST NOT depend on:

* RGBSIG or presentation metadata
* external trust scoring systems
* UI or client-side state

## Security Boundary

Delegation enforces strict separation between:

* identity ownership (CIR responsibility)
* authorization structure (RBAC responsibility)
* authority extension (delegation responsibility)
* execution (runtime layer responsibility)

Delegation MUST NOT:

* elevate privilege beyond original RBAC scope
* bypass CIR lifecycle enforcement
* override DENY decisions from permission scopes

## Dependency Requirements

Delegation depends on:

* CIR (identity state authority)
* RBAC system
* permission-scopes system

Delegation MUST NOT depend on:

* federation trust heuristics
* presentation-layer identity signals
* runtime UI or external scoring systems

## Determinism Constraint

Given identical:

* CIR state
* RBAC configuration
* delegation rules
* evaluation context

Delegation resolution MUST be identical across all instances.

No probabilistic or adaptive behavior is permitted.

## Summary

Delegation provides:

* controlled authority propagation between identities
* schema-defined constraint enforcement
* deterministic merging of permission scopes
* strict isolation from identity validation and presentation layers

It is a controlled extension mechanism, not a trust escalation system.
