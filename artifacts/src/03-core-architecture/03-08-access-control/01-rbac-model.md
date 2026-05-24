## 3.11.1 Role-Based Access Control (RBAC) Model

RBAC defines how roles map to permission scopes within the Asveora authorization system.

All RBAC behavior is defined by the schema:

`/schemas/access-control/rbac-model.schema.json`

and depends on:

`/schemas/access-control/permission-scopes.schema.json`

## Core Purpose

RBAC exists to:

* group atomic permission scopes into roles
* assign roles to CIR-backed identities
* provide deterministic authorization resolution

RBAC is strictly an authorization construct, not an identity construct.

Identity validity is handled exclusively by CIR.

## Schema Authority Rule

RBAC logic MUST NOT be implemented in prose systems.

The schema is authoritative:

* `rbac-model.schema.json` defines role structure
* `permission-scopes.schema.json` defines permission atoms

This document is a semantic interpretation layer only.

## Role Structure

A role consists of:

* role_id (immutable identifier)
* role_name (human-readable label)
* one or more permission scopes
* optional inheritance relationships

Each role:

* MUST be deterministic
* MUST be CIR-compatible
* MUST NOT encode identity validation logic

## Permission Binding Model

Each role binds to permissions via:

* permission-scopes schema instances
* optional conditional constraints
* explicit allow/deny effects (defined at permission level)

Roles do not define permissions directly — they aggregate them.

## Role Inheritance

Roles MAY inherit from other roles.

Inheritance rules:

* MUST form an acyclic graph
* MUST NOT override CIR state
* MUST preserve deterministic evaluation order

Inherited permissions are merged deterministically.

## Dependency Requirements

RBAC depends on:

* CIR (identity state authority)
* permission-scopes schema

RBAC MUST NOT depend on:

* federation trust signals
* RGBSIG (presentation layer)
* runtime UI state
* external authorization heuristics

## Evaluation Order

RBAC evaluation occurs after identity validation:

1. CIR validation completes
2. identity resolved via AUID
3. roles resolved from identity binding
4. permissions aggregated
5. evaluation passed to execution layer

## Determinism Constraint

Given identical inputs:

* CIR state
* role configuration
* permission definitions

RBAC MUST produce identical authorization outcomes across all instances.

No contextual variance is permitted.

## Security Boundary

RBAC enforces strict separation between:

* identity (CIR responsibility)
* authorization (RBAC responsibility)
* execution (runtime layer responsibility)

RBAC MUST NOT validate identity.

RBAC MUST NOT infer trust outside defined permissions.

## Summary

RBAC in Asveora provides:

* deterministic role grouping
* CIR-backed identity authorization mapping
* schema-driven permission aggregation
* strict separation from identity validation systems

It is a structural authorization layer, not a trust system.
