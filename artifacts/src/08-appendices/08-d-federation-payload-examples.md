## 1. Purpose

This document defines canonical examples of federation payloads used for synchronization between Asveora nodes.

These examples demonstrate:

* registry state propagation formats
* identity synchronization messages
* divergence signaling structures
* reconciliation payloads
* fail-closed federation communications



## 2. Federation Payload Constraint Rule

### Constraint

> Federation payloads MUST NOT be treated as authoritative system state.

All payloads are:

* transient
* validation-dependent
* subject to registry reconciliation
* never directly authoritative

Authority remains exclusively with the registry.



## 3. Standard Registry Sync Payload

### 3.1 Committed State Broadcast

```json id="fed_1a7c9b"
{
  "type": "registry_sync",
  "state": "committed",
  "source_node": "node://registry.us-east-1",
  "timestamp": "2026-05-13T10:20:00Z",
  "payload": {
    "CIR": "cir_9f2a1c7b",
    "lifecycle_state": "active",
    "AUID": "node://registry.us-east-1=8F3A91C2D7B4E9-9C12AB77D3F0E1"
  }
}
```



## 4. Identity Synchronization Payload

### 4.1 CIR-Aligned Identity Sync

```json id="fed_8k2p4x"
{
  "type": "identity_sync",
  "identity_type": "CIR",
  "source_node": "node://federation.eu-west-2",
  "registry_state": "validated",
  "payload": {
    "CIR": "cir_fed_1122aa",
    "lifecycle_state": "active"
  }
}
```



## 5. Federation Divergence Payload

### 5.1 Node State Conflict Report

```json id="fed_d9x3mq"
{
  "type": "federation_divergence",
  "severity": "high",
  "detected_at": "2026-05-13T10:25:00Z",
  "nodes_involved": [
    "node://registry.us-east-1",
    "node://federation.eu-west-2"
  ],
  "conflict_type": "registry_state_mismatch",
  "resolution_required": true
}
```



### Constraint

> Divergence payloads MUST NOT include mutable resolution instructions.



## 6. Reconciliation Request Payload

### 6.1 Registry Reconciliation Trigger

```json id="fed_r3t7vz"
{
  "type": "reconciliation_request",
  "trigger": "divergence_detected",
  "priority": "critical",
  "target_nodes": [
    "node://registry.us-east-1",
    "node://federation.eu-west-2"
  ],
  "resolution_mode": "registry_authority_override"
}
```



## 7. Fail-Closed Federation Payload

### 7.1 Unsafe State Detection

```json id="fed_fc9l1q"
{
  "type": "federation_fail_closed",
  "status": "blocked",
  "reason": "inconsistent_registry_state",
  "action": "synchronization_halted",
  "exposure_allowed": false
}
```



### Constraint

> Fail-closed federation payloads MUST NOT propagate state forward.



## 8. Node Join Payload

### 8.1 Federation Enrollment

```json id="fed_j7m2xk"
{
  "type": "node_join",
  "node_id": "node://federation.ap-south-1",
  "capabilities": [
    "registry_sync",
    "identity_validation",
    "read_replica"
  ],
  "status": "pending_validation"
}
```



## 9. Node Removal Payload

### 9.1 Federation Exit Event

```json id="fed_x4q9az"
{
  "type": "node_exit",
  "node_id": "node://federation.eu-central-1",
  "reason": "revocation_or_failure",
  "state": "decommissioned"
}
```



## 10. Partial Sync (Restricted State)

### 10.1 Limited Visibility Sync

```json id="fed_r5p8cn"
{
  "type": "registry_sync",
  "state": "restricted",
  "source_node": "node://federation.us-west-2",
  "payload": {
    "CIR": "cir_4b91d2aa"
  },
  "reason": "exposure_policy_enforced"
}
```



## 11. Deterministic Propagation Requirement

Federation payload handling MUST ensure:

* identical input state produces identical propagated state
* no probabilistic resolution of conflicts
* no hidden transformation of identity structures
* no authority escalation through messaging layer



## 12. Exposure Constraint in Federation

Federation payloads MUST comply with:

* Section 5 (Exposure Model)
* EDS filtering rules
* suppression constraints

### Constraint

> Federation MUST NOT transmit reconstructable identity structures when restricted by EDS.



## 13. Security Constraints

Federation payloads MUST prevent:

* identity spoofing across nodes
* registry injection attacks
* divergence masking
* unauthorized state elevation
* cross-node CIR reconstruction inference



## 14. Structural Invariants

All federation payloads MUST preserve:

* registry authority supremacy
* non-authoritative messaging semantics
* deterministic structure format
* fail-closed propagation behavior
* exposure compliance alignment



## 15. Relationship to RFC System

This document depends on:

* Section 3 (Core Architecture)
* Section 4 (Registry System)
* Section 5 (Exposure Model)
* Section 6 (Security Considerations)
* Section 7 (Implementation Guide)
