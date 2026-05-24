## 1. Purpose

This document defines the **Federation Exposure Behavior Model (FEB)** governing how identity exposure is handled across **federated Asveora instances**.

Federation introduces cross-domain identity resolution constraints where:

> AUID, APC, PIK, and VSIG may exist across multiple trust domains with differing authorization contexts.

This specification governs:

* Cross-federation identity visibility alignment
* Exposure normalization across domains
* Conflict resolution between local and federated IVL states
* Controlled identity propagation boundaries



## 2. Core Principle

Federation does not extend trust automatically.

Therefore:

> Exposure permissions are **never inherited across federation boundaries without explicit reconciliation via schema-defined trust alignment**.

Key constraint:

> Each federated node evaluates exposure independently before reconciliation.



## 3. Federation Exposure Model

Federation exposure is defined as a two-stage process:

```text id="fed_model"
Local Evaluation → Federation Normalization → Reconciliation Layer
```

Where:

* **Local Evaluation** = IVL + APC + AUID + disclosure rules applied per node
* **Federation Normalization** = schema-aligned translation of exposure states
* **Reconciliation Layer** = deterministic merging of exposure results



## 4. Federation Identity Units

Federation operates over the following identity units:

* **CIR (Identity Truth Layer)**
* **AUID (Unified Descriptor)**
* **APC (Core Binding Unit)**
* **PIK (Primary Identity Key)**
* **VSIG (Verification Signature)**

Constraint:

> Federation NEVER operates on raw CIR state directly; it operates only on resolved exposure representations.



## 5. Federation Exposure States

Federated exposure introduces extended states beyond local IVL:

```text id="fed_states"
FULLY_ALIGNED
PARTIALLY_ALIGNED
CONFLICTED
ISOLATED
SUPPRESSED
```



## 6. State Definitions

### 6.1 FULLY_ALIGNED

Definition:

> All federated nodes produce equivalent exposure outcomes for identity components.

Properties:

* AUID, APC, PIK, VSIG consistent across nodes
* No divergence in IVL interpretation
* No reconciliation adjustment required

Constraint:

* Requires schema-locked uniformity across federation



### 6.2 PARTIALLY_ALIGNED

Definition:

> Minor differences exist between federated exposure states but are reconcilable.

Properties:

* Differences limited to masking or tokenization levels
* Structural identity remains consistent
* Reconciliation produces deterministic convergence

Constraint:

> No identity component divergence allowed (PIK/VSIG must remain consistent)



### 6.3 CONFLICTED

Definition:

> Federated nodes produce incompatible exposure states for the same identity.

Properties:

* IVL mismatch across domains
* APC state divergence detected
* AUID representation mismatch possible

Constraint:

> Must trigger resolution via stricter exposure selection (fail-down behavior)

Resolution Rule:

> Always resolve to most restrictive valid exposure state.



### 6.4 ISOLATED

Definition:

> Identity exists in only one federated domain without cross-node visibility.

Properties:

* No cross-federation correlation exists
* Identity treated as local-only
* No propagation permitted

Constraint:

> Cannot be elevated without explicit federation registration



### 6.5 SUPPRESSED

Definition:

> Identity is removed from all federated exposure layers.

Properties:

* No representation across any node
* No reconciliation participation
* No indexing or propagation allowed

Constraint:

* Terminal state across federation



## 7. Federation Reconciliation Rules

Federation reconciliation MUST follow deterministic ordering:

### 7.1 Strictest-State Wins Rule

If conflict exists:

> The most restrictive exposure state is selected.

Priority order:

```text id="fed_priority"
SUPPRESSED > ISOLATED > CONFLICTED > PARTIALLY_ALIGNED > FULLY_ALIGNED
```



### 7.2 Component Consistency Rule

Across all federated nodes:

* PIK MUST remain identical or suppressed
* VSIG MUST remain cryptographically consistent or suppressed
* APC structure MUST remain stable or suppressed
* AUID MUST reflect resolved APC + APA consistency



### 7.3 No Partial Trust Propagation Rule

Federation MUST NOT:

* propagate partial authorization
* elevate local IVL to federated level
* merge incompatible VSIG states



## 8. Interaction with Local Exposure System

Federation behavior is applied **after local evaluation**:

```text id="fed_pipeline"
Stage 1 → Local IVL Evaluation  
Stage 2 → AUID Exposure Policy (05-05)  
Stage 3 → APC Exposure Constraints (05-06)  
Stage 4 → PIK/VSIG Disclosure Rules (05-07)  
Stage 5 → Federation Exposure Normalization (this spec)  
Stage 6 → Reconciliation Engine  
Stage 7 → Exposure Decision Set Assembly
```



## 9. Cross-Domain Identity Mapping

Federation MUST preserve identity equivalence through:

```text id="fed_map"
[AUID_local] ⇄ [AUID_federated]
```

Rules:

* Mapping must be deterministic
* No identity mutation permitted
* Tokenized identities must remain stable across nodes

Constraint:

> Federation does not generate new identity; it only reconciles existing representations.



## 10. Deterministic Evaluation Function

```text id="fed_fn"
FederatedExposure =
f(LocalExposureStates, NodeTrustGraph, IVL_Set, APC_State, SchemaConstraints)
```

Constraints:

* MUST be deterministic
* MUST be schema-version locked
* MUST not depend on runtime external network variability



## 11. Failure Model

### 11.1 Node Desynchronization

If federated nodes cannot reconcile:

* MUST default to CONFLICTED → resolved to SUPPRESSED



### 11.2 Schema Mismatch

If schema versions differ across nodes:

* MUST default to SUPPRESSED



### 11.3 Identity Divergence

If PIK or VSIG mismatch detected:

* MUST suppress entire identity across federation



## 12. Security Constraints

Federation introduces amplified risk of identity correlation.

Therefore:

* No cross-node reconstruction of suppressed components
* VSIG must never be transmitted in partial form across nodes
* PIK must not be derivable through federated aggregation
* AUID must remain structurally consistent across nodes

Security principle:

> Federation is a reconciliation system, not a trust amplification system.



## 13. System Invariants

The following MUST always hold:

* SUPPRESSED overrides all federation states
* Strictest exposure state always wins
* No federated node may elevate exposure independently
* VSIG consistency is non-negotiable
* Identity mutation across nodes is prohibited
