## 3.11.2 Permission Scopes (Atomic Authorization Model)

Permission scopes define the smallest enforceable unit of authorization within the Asveora system.

All permission behavior is defined by the schema:

`/schemas/access-control/permission-scopes.schema.json`

## Core Purpose

Permission scopes exist to:

* define a single action over a single resource
* enforce deterministic allow/deny rules
* serve as the atomic building block of RBAC and delegation

A permission scope answers:

“Can this action be performed on this resource under these conditions?”

## Schema Authority Rule

All permission logic MUST be derived from schema definitions.

The authoritative schema is:

`/schemas/access-control/permission-scopes.schema.json`

This document does NOT define execution behavior — it defines meaning and constraints.

## Permission Structure

Each permission scope consists of:

* permission_id (unique identifier)
* resource (target system domain or object class)
* action (operation to be performed)
* effect (ALLOW or DENY)
* optional conditions (contextual constraints)

## Atomicity Rule

A permission scope MUST:

* represent exactly one action
* target exactly one logical resource domain
* remain independently evaluable without external resolution chains

Permissions MUST NOT be compound policies.

## Evaluation Model

Permission evaluation occurs only after:

1. CIR identity validation
2. identity resolution via AUID
3. RBAC role aggregation

Then:

* permission scopes are evaluated independently
* conditions are applied deterministically
* effect is resolved (ALLOW or DENY)

## Conditional Logic

Permissions MAY include conditions such as:

* identity state (ACTIVE, MIGRATING, etc.)
* instance origin constraints
* time or lifecycle constraints
* delegation overrides

Conditions MUST remain deterministic and schema-bound.

Conditions MUST NOT depend on:

* UI state
* presentation metadata (RGBSIG)
* external trust scoring systems

## Effect Rules

Each permission scope MUST resolve to one of:

* ALLOW
* DENY

DENY always overrides ALLOW within the same evaluation scope.

## Dependency Requirements

Permission scopes depend on:

* CIR (identity state authority for evaluation context)
* RBAC system (for aggregation)

Permission scopes MUST NOT depend on:

* federation trust models
* UI/presentation layers
* runtime heuristics outside defined conditions

## Determinism Constraint

Given identical:

* CIR state
* permission definition
* evaluation context

Permission resolution MUST be identical across all instances.

No stochastic or adaptive behavior is permitted.

## Security Boundary

Permission scopes enforce strict separation between:

* identity validity (CIR responsibility)
* role aggregation (RBAC responsibility)
* authorization decision (permission evaluation responsibility)

Permissions MUST NOT evaluate identity authenticity.

## Summary

Permission scopes provide:

* atomic authorization units
* deterministic allow/deny evaluation
* schema-enforced condition handling
* strict isolation from identity and presentation systems

They are the fundamental executable units of Asveora authorization logic.
