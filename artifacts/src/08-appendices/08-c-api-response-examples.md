## 1. Purpose

This document provides canonical examples of API responses emitted by the Asveora system.

These examples demonstrate:

* post-evaluation output structure
* exposure-filtered responses
* identity-safe emission formats
* error and suppression behaviors
* deterministic API output formatting



## 2. API Emission Constraint Rule

### Constraint

> API responses are emission-only artifacts and MUST NOT include internal computation state.

API outputs MUST:

* reflect post-EDS evaluation results only
* exclude raw registry internals
* exclude federation topology details
* exclude authorization decision trees
* exclude schema validation artifacts



## 3. Successful Identity Query Response

### 3.1 Standard Identity Response

```json id="api_1a9f2c"
{
  "status": "success",
  "data": {
    "CIR": "cir_9f2a1c7b",
    "AUID": "node://registry.us-east-1=8F3A91C2D7B4E9-9C12AB77D3F0E1",
    "lifecycle_state": "active"
  },
  "exposure_level": "standard"
}
```



### 3.2 Federated Identity Response

```json id="api_8k3d11"
{
  "status": "success",
  "data": {
    "CIR": "cir_fed_1122aa",
    "AUID": "node://federation.eu-west-2=BB12CC34DD56EE78-9988AABBCCDD1122",
    "federation_state": "synchronized"
  },
  "exposure_level": "federated_view"
}
```



## 4. Restricted Response Example

### 4.1 Partial Identity Exposure

```json id="api_r7x2pz"
{
  "status": "restricted",
  "data": {
    "CIR": "cir_4b91d2aa"
  },
  "reason": "exposure_policy_restriction",
  "exposure_level": "minimal"
}
```



### Constraint

> Restricted responses MUST NOT expose reconstructable identity structures (APC or full AUID).



## 5. Suppressed Response Example

### 5.1 Full Suppression Case

```json id="api_s9l4qv"
{
  "status": "suppressed",
  "data": null,
  "reason": "eds_reconstruction_risk_detected",
  "exposure_level": "none"
}
```



### Constraint

> Suppressed responses MUST NOT include partial identity artifacts.



## 6. Error Response Examples

### 6.1 Validation Failure

```json id="api_e1v7kc"
{
  "status": "error",
  "error_code": "SCHEMA_VALIDATION_FAILED",
  "message": "Invalid identity structure",
  "exposure_level": "none"
}
```



### 6.2 Registry Conflict

```json id="api_e9b2mz"
{
  "status": "error",
  "error_code": "REGISTRY_CONFLICT",
  "message": "Conflicting registry state detected",
  "exposure_level": "none"
}
```



### 6.3 Federation Divergence

```json id="api_e4t8nx"
{
  "status": "error",
  "error_code": "FEDERATION_DIVERGENCE",
  "message": "Node state inconsistency detected",
  "exposure_level": "restricted"
}
```



## 7. Fail-Closed Response Example

```json id="api_fc9z1p"
{
  "status": "failed_closed",
  "data": null,
  "reason": "system_integrity_violation",
  "exposure_level": "none"
}
```



### Constraint

> Fail-closed responses MUST NOT reveal internal system state.



## 8. Migration-In-Progress Response

```json id="api_m3q8vt"
{
  "status": "in_progress",
  "operation": "migration",
  "CIR": "cir_9f2a1c7b",
  "migration_state": "locked",
  "exposure_level": "restricted"
}
```



## 9. Identity Revocation Response

```json id="api_rv2k9s"
{
  "status": "success",
  "data": {
    "CIR": "cir_77aa91ff",
    "lifecycle_state": "revoked"
  },
  "exposure_level": "revoked_view"
}
```



## 10. Deterministic Output Rule

All API responses MUST satisfy:

* identical input state → identical output
* no runtime randomness in formatting
* no inference beyond evaluated state
* no exposure of hidden system layers



## 11. Exposure Alignment Constraint

All API outputs MUST comply with:

* Section 5 (Exposure Model)
* EDS evaluation results
* suppression rules
* reconstruction risk filtering

### Constraint

> API MUST NEVER override exposure decisions.



## 12. Structural Invariants

All API responses MUST preserve:

* emission-only semantics
* post-evaluation state representation
* deterministic structure
* non-reconstructive identity exposure
* fail-closed consistency behavior



## 13. Relationship to RFC System

This document depends on:

* Section 3 (Core Architecture)
* Section 4 (Registry System)
* Section 5 (Exposure Model)
* Section 6 (Security Considerations)
* Section 7 (Implementation Guide)
