## 1. Purpose

This document defines reference architecture patterns for deploying and operating the Asveora system.

These architectures describe:

* structural composition of system layers
* deployment topologies
* federation layouts
* registry placement strategies
* isolation and execution boundaries



## 2. Architecture Constraint Rule

### Constraint

> Reference architectures are illustrative deployment patterns and MUST NOT override normative rules in Sections 3–7.

If conflicts occur:

* schema definitions are authoritative
* registry rules define truth
* implementation guide (Section 7) governs execution behavior



## 3. Core Layered Architecture

### 3.1 Standard Asveora Stack

```text id="arch_core_stack"
[API Layer]
     ↓
[Exposure Decision System (EDS)]
     ↓
[Governance Layer]
     ↓
[Authorization Layer (RBAC + Delegation)]
     ↓
[Federation Layer]
     ↓
[Registry System]
     ↓
[Identity Core (CIR / APC / VSIG / AUID)]
     ↓
[Schema Layer]
     ↓
[Wheelcore Execution Substrate]
```



### 3.2 Architecture Description

This is the canonical single-instance logical architecture:

* Schema layer defines system truth rules
* Identity core defines entity truth
* Registry enforces persistence integrity
* Federation propagates state (non-authoritative)
* Authorization enforces access structure
* Governance enforces runtime control
* EDS enforces exposure filtering
* API emits final outputs



## 4. Federated Multi-Node Architecture

### 4.1 Distributed Node Model

```text id="arch_federated"
          [Node A] -- [Node B]
             |                     |
             |                     |
          [Node C] -- [Node D]

                 ↓ shared synchronization ↓

              [Registry Consistency Layer]
```



### 4.2 Properties

* each node contains full or partial registry replica
* nodes synchronize via federation layer
* registry remains logical authority
* divergence is resolved via fail-closed rules



### Constraint

> No node is an authority over global system truth.



## 5. High-Availability Cluster Architecture

### 5.1 HA Deployment Model

```text id="arch_ha"
         [Load Balancer]
                ↓
   ┌────────────┼────────────┐
   ↓            ↓            ↓
[Node 1]     [Node 2]     [Node 3]
   ↓            ↓            ↓
   └───────[Shared Registry]───────┘
```



### 5.2 Properties

* replicated execution nodes
* synchronized registry state
* deterministic failover
* consistent identity resolution across nodes



## 6. Isolated Single-Node Architecture

### 6.1 Standalone System Model

```text id="arch_single"
[API]
  ↓
[EDS]
  ↓
[Governance]
  ↓
[Authorization]
  ↓
[Registry]
  ↓
[Identity Core]
  ↓
[Schema]
  ↓
[Wheelcore]
```



### 6.2 Properties

* no federation layer active
* no cross-node synchronization
* full deterministic execution locally
* used for testing, validation, or isolated environments



## 7. Registry-Centric Architecture

### 7.1 Registry Authority Model

```text id="arch_registry_centric"
         [Federation Layer]
                ↓
         [Authorization Layer]
                ↓
         [Exposure Layer (EDS)]
                ↓
         [API Layer]
                ↓
        ┌──────────────────┐
        │  Registry System │
        └──────────────────┘
                ↑
     [Identity + Schema Enforcement]
```



### 7.2 Key Principle

> Registry is the single source of truth across all architectures.



## 8. Failure-Isolated Architecture

### 8.1 Fail-Closed System Model

```text id="arch_fail_closed"
[API]
  ↓
[EDS]
  ↓
[Governance]
  ↓
   ❌ FAILURE DETECTED
  ↓
[SUPPRESSION / HALT / RESTRICTED MODE]
```



### 8.2 Behavior

* system halts or restricts output under inconsistency
* no degraded unsafe mode allowed
* no partial identity exposure permitted



## 9. Exposure-Controlled Architecture

### 9.1 EDS-Centric Flow

```text id="arch_eds"
[Identity + Registry State]
            ↓
        [EDS Filter]
     ↓        ↓        ↓
 [Allowed] [Restricted] [Suppressed]
     ↓
   [API Emission]
```



### Constraint

> EDS is the final control point before external visibility.



## 10. Performance vs Integrity Architecture Constraint

All architectures MUST prioritize:

* deterministic correctness
* registry consistency
* identity integrity
* exposure safety

Performance optimizations MUST NOT:

* bypass registry validation
* weaken federation consistency
* alter exposure evaluation logic



## 11. Security Architecture Constraints

All architectures MUST prevent:

* cross-node identity leakage
* registry bypass via federation shortcuts
* exposure pipeline circumvention
* unauthorized schema mutation
* identity reconstruction from API outputs



## 12. Structural Invariants

All reference architectures MUST preserve:

* schema supremacy
* registry authority dominance
* deterministic execution flow
* fail-closed system behavior
* strict layer separation



## 13. Relationship to RFC System

This document depends on:

* Section 3 (Core Architecture)
* Section 4 (Registry System)
* Section 5 (Exposure Model)
* Section 6 (Security Considerations)
* Section 7 (Implementation Guide)
