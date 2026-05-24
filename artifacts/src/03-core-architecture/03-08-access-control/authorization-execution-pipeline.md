## 3.11.5 Authorization Execution Pipeline

## 1. Purpose

The Authorization Execution Pipeline defines the **deterministic sequence** by which an Asveora Network Instance evaluates whether an identity may perform an action.

It unifies:

* RBAC evaluation
* permission resolution
* delegation chaining
* service identity constraints
* federation context signals
* lifecycle validation
* runtime enforcement

It answers:

> “How does a system deterministically decide whether to allow an action?”

## 2. Core Principle

Authorization in Asveora is:

* **CIR-backed**
* **deterministic**
* **locally sovereign**
* **federation-aware but never federation-controlled**
* **strictly separated from identity validation**

No step in this pipeline may violate these invariants.

## 3. Input Object (Authorization Request Context)

All authorization decisions begin with a normalized request:

### Authorization Request (AR)

* identity reference → AUID (resolved from APA + PIK + VSIG)
* requested action → operation identifier
* target resource → optional scoped object
* execution context → runtime + federation metadata
* instance context → local Network Instance ID

## 4. Pipeline Stages

The pipeline MUST execute in the following deterministic order.

## Stage 1 — Identity Resolution

### Source systems:

* AUID resolver
* CIR registry lookup

### Actions:

* Resolve PIK
* Validate VSIG
* Fetch CIR snapshot
* Confirm identity existence

### Failure condition:

If CIR is invalid or missing:

→ **DENY (INVALID_IDENTITY)**

## Stage 2 — Identity Lifecycle Validation

### Input:

CIR identity state

### Rules:

| State       | Result                 |
| ----------- | ---------------------- |
| ACTIVE      | continue               |
| MIGRATING   | conditional evaluation |
| TOMBSTONED  | deny                   |
| INVALIDATED | deny                   |

### Failure:

→ **DENY (LIFECYCLE_RESTRICTION)**

## Stage 3 — Role Resolution (RBAC Layer)

### Source:

`01-rbac-model.md`

### Actions:

* Load assigned roles
* Resolve role hierarchy
* Expand inherited permissions

### Output:

Flattened role set

## Stage 4 — Permission Resolution

### Source:

`02-permissions.md`

### Actions:

* Evaluate direct permissions
* Apply policy rules
* Apply contextual constraints
* Validate scope boundaries

### Hard constraint:

* RGBSIG and all presentation metadata MUST be ignored

### Output:

Effective permission set (EPS)

## Stage 5 — Delegation Resolution

### Source:

`03-delegation.md`

### Actions:

* Evaluate delegated authority chains
* Validate revocation state
* Apply delegation scope limits
* Resolve parent authority constraints

### Rule:

Delegation MUST NOT exceed origin authority

### Output:

Adjusted permission set (APS)

## Stage 6 — Service Identity Check

### Source:

`04-service-identities.md`

### Actions:

* Determine if identity is service/system identity
* Apply stricter constraints if true:

  * reduced privilege ceilings
  * scoped execution boundaries
  * audit requirement enforcement

### Rule:

Service identities cannot escalate privileges via delegation or federation

## Stage 7 — Federation Context Evaluation (Advisory Only)

### Inputs:

* federation trust signals
* remote instance metadata
* synchronization state

### Rules:

* MAY influence *risk scoring*
* MUST NOT override local authorization logic
* MUST NOT modify permission truth

### Output:

Context modifier (CM) — non-authoritative

## Stage 8 — Policy Composition Engine

### Inputs:

* APS (permissions + delegation result)
* RBAC output
* lifecycle constraints
* service identity constraints
* CM (federation context)

### Process:

Compute final authorization decision using deterministic policy evaluation.

### Key rule:

> No single layer is authoritative alone — only combined evaluation is valid.

## Stage 9 — Decision Engine

Produces final decision:

### Possible outcomes:

* ALLOW
* DENY
* CONDITIONAL_ALLOW

### With reason codes:

* INVALID_IDENTITY
* INSUFFICIENT_PERMISSION
* DELEGATION_EXCEEDED
* LIFECYCLE_RESTRICTED
* SERVICE_CONSTRAINT_VIOLATION
* POLICY_REJECTION

## Stage 10 — Enforcement Layer

### Runtime execution:

* API gateway enforcement
* system call gating
* event execution control
* registry write protection

### Rule:

> Enforcement occurs ONLY after final decision is produced.

## Stage 11 — Audit & Event Logging

Every decision MUST emit:

* identity reference (AUID)
* evaluated roles
* applied permissions
* delegation chain summary
* service identity flag
* federation context summary (if present)
* final decision
* reason code

Stored in:

* Governance Event Log
* Audit subsystem

## 5. Determinism Requirement

For any identical input:

> AR + CIR + policy state MUST always produce identical output

No exceptions:

* no UI influence
* no timing variance
* no federation override
* no presentation-layer dependency

## 6. Security Invariants

The pipeline enforces:

* Identity ≠ Authorization
* Presentation ≠ Policy
* Federation ≠ Authority
* Service execution ≠ privilege escalation
* Delegation ≠ unlimited inheritance

## 7. Relationship to Modular Access Control System

This pipeline is the **ORCHESTRATION LAYER** over:

* RBAC model
* permissions system
* delegation system
* service identity system

Those files define *rules*.

This defines **execution order**.

## 8. Design Intent

The Authorization Execution Pipeline exists to:

* unify modular access control components
* enforce deterministic evaluation order
* eliminate ambiguity in authorization decisions
* support federation-aware but sovereign decision-making
* ensure reproducibility across all instances
