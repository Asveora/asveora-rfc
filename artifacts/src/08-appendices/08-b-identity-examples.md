## 1. Purpose

This document provides canonical examples of identity structures used in the Asveora system.

These examples illustrate:

* CIR composition
* APC formatting
* AUID construction
* valid structural relationships between identity components



## 2. Example Constraint Rule

### Constraint

> All examples in this document are illustrative only and MUST NOT override schema definitions or RFC rules in Sections 3–7.

If inconsistencies exist:

* schema definitions take precedence
* Sections 3–7 define authoritative behavior
* this document serves only as reference material



## 3. CIR (Core Identity Record) Example

### 3.1 Basic CIR Example

```json
{
  "CIR": {
    "id": "cir_9f2a1c7b",
    "status": "active",
    "registry_state": "committed",
    "lifecycle_state": "active",
    "created_at": "2026-05-13T10:15:00Z"
  }
}
```

### 3.2 CIR with Lifecycle Transition

```json
{
  "CIR": {
    "id": "cir_4b91d2aa",
    "status": "migrating",
    "registry_state": "locked",
    "previous_state": "active",
    "target_state": "active_v2",
    "migration_id": "mig_7781",
    "created_at": "2026-05-13T11:00:00Z"
  }
}
```



## 4. APC (Asveora Profile Core) Examples

### 4.1 Standard APC Format

```text
[PIK]-[VSIG]
```

### 4.2 Valid APC Example

```text
PIK-8F3A91C2D7B4E9
VSIG-9C12AB77D3F0E1
```

### 4.3 Combined APC Structure

```text
8F3A91C2D7B4E9-9C12AB77D3F0E1
```

### Interpretation:

* Left side = PIK
* Right side = VSIG



## 5. AUID (Asveora Unified Identity Descriptor) Examples

### 5.1 Standard AUID Format

```text
[APA]=[PIK]-[VSIG]
```



### 5.2 Valid AUID Example

```text
node://registry.us-east-1=8F3A91C2D7B4E9-9C12AB77D3F0E1
```



### 5.3 AUID with Different Namespace Context

```text
node://federation.eu-west-2=AA91BC44DE7788-12FF9A33CC5566
```



## 6. Identity Relationship Example

### 6.1 Full Identity Binding Example

```json
{
  "CIR": "cir_9f2a1c7b",
  "APC": "8F3A91C2D7B4E9-9C12AB77D3F0E1",
  "AUID": "node://registry.us-east-1=8F3A91C2D7B4E9-9C12AB77D3F0E1",
  "registry_state": "committed",
  "lifecycle_state": "active"
}
```



### 6.2 Federated Identity Representation

```json
{
  "CIR": "cir_fed_1122aa",
  "local_node": "node://federation.eu-west-2",
  "APC": "BB12CC34DD56EE78-9988AABBCCDD1122",
  "AUID": "node://federation.eu-west-2=BB12CC34DD56EE78-9988AABBCCDD1122",
  "federation_state": "synchronized",
  "registry_state": "committed"
}
```



## 7. Invalid Identity Examples (For Contrast)

### 7.1 Missing VSIG (Invalid APC)

```text
PIK-8F3A91C2D7B4E9
```

❌ Invalid because VSIG is required



### 7.2 Detached AUID (Invalid)

```text
node://registry.us-east-1=UNKNOWN-IDENTITY
```

❌ Invalid because PIK/VSIG binding is not registry-valid



### 7.3 Unregistered CIR Reference

```json
{
  "CIR": "cir_unknown",
  "status": "active"
}
```

❌ Invalid because CIR is not registry-backed



## 8. Identity Validation Constraints

All valid identities MUST:

* be registry-bound
* have deterministic APC structure
* maintain CIR linkage
* respect lifecycle state rules
* pass schema validation



## 9. Structural Invariants

Valid identity structures MUST preserve:

* CIR as root identity anchor
* APC as derived representation only
* AUID as contextual descriptor only
* registry as source of truth
* lifecycle state consistency across all forms



## 10. Relationship to RFC System

Identity examples depend on:

* Section 3 (Core Architecture)
* Section 4 (Registry System)
* Section 5 (Exposure Model)
* Section 6 (Security Model)
* Section 7 (Implementation Guide)