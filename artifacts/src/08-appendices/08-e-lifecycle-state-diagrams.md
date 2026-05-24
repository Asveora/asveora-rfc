## 1. Purpose

This document defines canonical lifecycle state diagrams for identity and system entities in Asveora.

It provides standardized transition models for:

* CIR lifecycle states
* registry entries
* migration states
* revocation flows
* federation-aligned transitions



## 2. Diagram Constraint Rule

### Constraint

> Lifecycle diagrams are illustrative representations and MUST NOT override formal lifecycle rules defined in Sections 3–7.

If conflicts occur:

* Section 4 (Registry System) is authoritative
* Section 7 (Implementation Guide) governs execution behavior
* this document is interpretive only



## 3. CIR Lifecycle State Model

### 3.1 CIR State Diagram

```text id="cir_lifecycle"
[provisioned]
      ↓
[validating]
      ↓
[active]
   ↓     ↓
[revoked] [migrating]
              ↓
          [active_v2]
```



### 3.2 CIR State Definitions

* **provisioned** → initial creation state
* **validating** → schema + registry verification phase
* **active** → fully valid and operational identity
* **revoked** → permanently invalidated identity
* **migrating** → transition state during controlled change
* **active_v2** → post-migration committed identity state



## 4. Registry Entry Lifecycle

### 4.1 Registry State Diagram

```text id="registry_lifecycle"
[uncommitted]
      ↓
[validated]
      ↓
[committed]
   ↓        ↓
[locked]  [deprecated]
      ↓
  [committed_v2]
```



### 4.2 Registry State Definitions

* **uncommitted** → initial unverified state
* **validated** → schema-confirmed entry
* **committed** → authoritative registry state
* **locked** → write-protected transitional state
* **deprecated** → superseded but retained entry
* **committed_v2** → updated authoritative version



## 5. Migration Lifecycle

### 5.1 Migration State Diagram

```text id="migration_lifecycle"
[initiated]
      ↓
[validated]
      ↓
[locked]
      ↓
[executing]
      ↓
[verified]
   ↓        ↓
[committed] [rolled_back]
```



### 5.2 Migration State Definitions

* **initiated** → migration request created
* **validated** → schema and registry approved
* **locked** → system state frozen
* **executing** → transformation in progress
* **verified** → post-migration validation complete
* **committed** → final applied state
* **rolled_back** → restoration to pre-migration state



## 6. Federation State Transitions

### 6.1 Node State Diagram

```text id="federation_lifecycle"
[discovered]
      ↓
[validated]
      ↓
[active]
   ↓        ↓
[diverged] [degraded]
      ↓
[synchronized]
```



### 6.2 Federation State Definitions

* **discovered** → node detected but not validated
* **validated** → schema-compatible node confirmed
* **active** → participating in federation
* **diverged** → state inconsistency detected
* **degraded** → partial failure mode
* **synchronized** → consistent with registry truth



## 7. Exposure State Model (EDS)

### 7.1 Exposure Flow Diagram

```text id="eds_lifecycle"
[input state]
      ↓
[evaluation]
      ↓
[allowed] ─────→ [emitted]
      ↓
[restricted]
      ↓
[suppressed]
```



### 7.2 Exposure State Definitions

* **allowed** → full output permitted
* **restricted** → partial output permitted
* **suppressed** → no output permitted
* **emitted** → final API response stage



## 8. API Lifecycle Behavior

### 8.1 API State Flow

```text id="api_lifecycle"
[request received]
      ↓
[validated upstream]
      ↓
[EDS evaluation]
      ↓
[response constructed]
      ↓
[emitted | suppressed | error]
```



## 9. Fail-Closed Lifecycle Transitions

At any state:

### Failure behavior MUST resolve as:

* invalid transition → rollback or suppression
* inconsistent state → halted execution
* unauthorized transition → denial
* partial state → discarded



## 10. Deterministic Transition Requirement

All lifecycle transitions MUST be deterministic:

* identical input state → identical next state
* no probabilistic branching allowed
* no external timing-based variation permitted



## 11. Cross-System Lifecycle Alignment

Lifecycle states MUST remain consistent across:

* CIR (identity)
* Registry entries
* Federation nodes
* Migration processes
* Exposure decisions
* API outputs

### Constraint

> No subsystem MAY expose a lifecycle state inconsistent with registry truth.



## 12. Security Constraints

Lifecycle transitions MUST prevent:

* unauthorized state escalation
* hidden transitional exposure
* federation-induced state corruption
* migration bypass of lifecycle validation
* exposure of internal intermediate states



## 13. Structural Invariants

All lifecycle models MUST preserve:

* registry authority supremacy
* deterministic transitions
* fail-closed enforcement
* non-reconstructive state exposure
* schema-aligned state progression



## 14. Relationship to RFC System

This document depends on:

* Section 3 (Core Architecture)
* Section 4 (Registry System)
* Section 5 (Exposure Model)
* Section 6 (Security Considerations)
* Section 7 (Implementation Guide)
