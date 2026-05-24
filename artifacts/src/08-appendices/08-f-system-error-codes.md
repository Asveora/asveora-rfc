## 1. Purpose

This document defines the canonical error codes used across the Asveora system.

These codes represent deterministic failure states emitted by:

* schema validation layer
* registry system
* identity resolution
* federation layer
* exposure decision system (EDS)
* API emission layer
* governance enforcement layer



## 2. Error Code Constraint Rule

### Constraint

> Error codes are standardized representations of system failure states and MUST NOT expose internal implementation details.

Error outputs MUST:

* remain non-reconstructive
* avoid exposing internal state graphs
* avoid revealing decision chain internals
* remain deterministic and consistent across instances



## 3. Error Code Structure

All error codes follow the format:

```text id="error_format"
ASV-<DOMAIN>-<CODE>
```

Where:

* **ASV** = Asveora System prefix
* **DOMAIN** = subsystem identifier
* **CODE** = deterministic numeric or symbolic identifier



## 4. Schema Layer Errors

### 4.1 ASV-SCH-001 — Schema Validation Failed

```json id="err_sch_001"
{
  "error_code": "ASV-SCH-001",
  "message": "Schema validation failed",
  "severity": "critical"
}
```

Triggered when input violates schema definitions.



### 4.2 ASV-SCH-002 — Schema Mismatch

Occurs when structure does not conform to expected schema version.



### 4.3 ASV-SCH-003 — Unsupported Schema Version

Schema version is not recognized or deprecated.



## 5. Registry System Errors

### 5.1 ASV-REG-001 — Registry Conflict

```json id="err_reg_001"
{
  "error_code": "ASV-REG-001",
  "message": "Registry state conflict detected",
  "severity": "critical"
}
```

Occurs when multiple authoritative registry states exist.



### 5.2 ASV-REG-002 — Uncommitted State Access

Access attempted on uncommitted registry entry.



### 5.3 ASV-REG-003 — Registry Lock Failure

System failed to acquire registry lock for atomic operation.



## 6. Identity System Errors

### 6.1 ASV-ID-001 — Invalid CIR

CIR does not exist or is not registry-valid.



### 6.2 ASV-ID-002 — APC Integrity Failure

```text id="err_id_002"
PIK-VSIG structure invalid or corrupted
```

Triggered when:

* PIK is missing or malformed
* VSIG verification fails



### 6.3 ASV-ID-003 — AUID Binding Error

AUID does not resolve to valid CIR + APC binding.



### Constraint

> Identity errors MUST NOT expose reconstructable identity components beyond allowed exposure rules.



## 7. Federation Errors

### 7.1 ASV-FED-001 — Node Divergence Detected

```json id="err_fed_001"
{
  "error_code": "ASV-FED-001",
  "message": "Federation divergence detected",
  "severity": "high"
}
```

Occurs when node states differ from registry truth.



### 7.2 ASV-FED-002 — Node Unreachable

Federation node cannot be contacted or validated.



### 7.3 ASV-FED-003 — Synchronization Failure

Failure during registry synchronization process.



## 8. Exposure System Errors (EDS)

### 8.1 ASV-EDS-001 — Suppression Triggered

```json id="err_eds_001"
{
  "error_code": "ASV-EDS-001",
  "message": "Exposure suppressed due to reconstruction risk",
  "severity": "high"
}
```



### 8.2 ASV-EDS-002 — Restricted Output

Partial output allowed under exposure constraints.



### 8.3 ASV-EDS-003 — Exposure Policy Violation

Attempted emission violates exposure rules.



## 9. API Layer Errors

### 9.1 ASV-API-001 — Emission Denied

API output blocked due to upstream failure.



### 9.2 ASV-API-002 — Invalid Response State

Response attempted from non-finalized system state.



### 9.3 ASV-API-003 — Fail-Closed Activation

System entered fail-closed emission mode.



## 10. Governance Errors

### 10.1 ASV-GOV-001 — Execution Denied

Governance explicitly blocks operation.



### 10.2 ASV-GOV-002 — Restricted Mode Active

System operating under constrained governance mode.



### 10.3 ASV-GOV-003 — Policy Conflict

Conflicting governance rules detected.



## 11. Migration Errors

### 11.1 ASV-MIG-001 — Migration Failed

```json id="err_mig_001"
{
  "error_code": "ASV-MIG-001",
  "message": "Migration aborted due to validation failure",
  "severity": "critical"
}
```



### 11.2 ASV-MIG-002 — Rollback Executed

Migration reverted to previous stable state.



### 11.3 ASV-MIG-003 — Partial State Detected

Invalid intermediate migration state detected.



## 12. Deterministic Error Requirement

All error outputs MUST satisfy:

* identical failure conditions → identical error code
* no runtime-dependent variation in codes
* no hidden internal state exposure
* no probabilistic error generation



## 13. Fail-Closed Error Behavior

Errors MAY trigger:

* suppression of output
* system halt
* restricted mode activation
* rollback of operations

### Constraint

> Errors MUST NOT result in undefined system states.



## 14. Security Constraints

Error systems MUST prevent:

* leakage of internal system topology
* exposure of hidden identity structure
* federation state reconstruction via errors
* registry inference through error patterns
* API-based reverse engineering of system logic



## 15. Structural Invariants

All error handling MUST preserve:

* deterministic classification
* non-reconstructive messaging
* subsystem isolation integrity
* fail-closed enforcement behavior
* registry-authoritative interpretation



## 16. Relationship to RFC System

This document depends on:

* Section 3 (Core Architecture)
* Section 4 (Registry System)
* Section 5 (Exposure Model)
* Section 6 (Security Considerations)
* Section 7 (Implementation Guide)
