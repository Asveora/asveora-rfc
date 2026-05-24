## 3.11.4 Service Identities Model (Machine Actor Authorization Layer)

Service identities define how non-human system actors operate within the Asveora authorization model.

All service identity behavior is defined by the schema:

/schemas/access-control/service-identities.schema.json

## Core Purpose

Service identities exist to:

* represent machine or system actors within Asveora
* bind automated processes to CIR-backed identity structures
* enforce RBAC-based authorization for system execution

Service identities are not privileged entities — they are constrained actors operating under the same authorization system as human identities.

## Schema Authority Rule

All service identity behavior MUST be derived from schema definitions.

The authoritative schema is:

/schemas/access-control/service-identities.schema.json

This document provides semantic interpretation only.

## Service Identity Structure

A service identity consists of:

* service_id (unique machine actor identifier)
* identity_binding (CIR-backed linkage via PIK and AUID)
* roles (RBAC role assignments)
* allowed_environments (execution constraints)
* rotation_policy (credential lifecycle rules)

## Identity Binding Model

Each service identity MUST be bound to:

* PIK (Primary Identity Key)
* AUID (resolvable identity reference)
* CIR-backed identity state

This ensures service actors remain fully integrated into the canonical identity system.

## Authorization Model

Service identities are authorized using the same pipeline as all other identities:

1. CIR validation
2. identity resolution via AUID
3. RBAC role evaluation
4. permission scope evaluation
5. delegation evaluation (if applicable)
6. runtime enforcement decision

Service identities do NOT bypass any stage of authorization.

## Operational Constraints

Service identities:

* MUST operate within assigned RBAC roles
* MUST respect CIR lifecycle state (ACTIVE, MIGRATING, etc.)
* MUST comply with delegation constraints
* MUST NOT self-escalate privileges
* MUST NOT modify authorization schemas or system rules

## Environment Constraints

Service identities MAY be restricted to:

* specific runtime environments
* defined network instances
* controlled execution zones

These constraints MUST be deterministic and schema-defined.

They MUST NOT depend on:

* external trust scoring systems
* UI or client-layer signals
* federated reputation heuristics

## Rotation and Lifecycle Policy

Service identity credentials MAY rotate based on:

* time-based expiration
* security policy enforcement
* CIR state changes
* administrative revocation events

Rotation MUST preserve identity continuity while updating credentials.

## Security Boundary

Service identities enforce strict separation between:

* system execution (service responsibility)
* authorization logic (RBAC and permission systems)
* identity validity (CIR responsibility)

Service identities MUST NOT:

* bypass RBAC evaluation
* override CIR lifecycle state
* act as authority over federation or registry systems

They are execution agents, not trust authorities.

## Dependency Requirements

Service identities depend on:

* CIR (identity state authority)
* RBAC system
* permission-scopes system
* delegation system (optional, contextual)

Service identities MUST NOT depend on:

* federation trust scores
* presentation-layer metadata
* runtime UI state

## Determinism Constraint

Given identical:

* CIR state
* RBAC configuration
* service identity binding
* execution context

Authorization outcomes MUST be identical across all instances.

No stochastic or adaptive behavior is permitted.

## Summary

Service identities provide:

* machine actor representation within Asveora
* CIR-backed identity binding for system processes
* strict RBAC-based authorization enforcement
* deterministic execution constraints

They ensure that automation operates under the same security model as all other identities in the system.
