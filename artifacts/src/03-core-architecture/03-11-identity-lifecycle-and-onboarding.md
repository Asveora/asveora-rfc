## 3.13.1 Identity Lifecycle and Onboarding

The Identity Lifecycle and Onboarding model defines how identities are introduced, validated, transitioned, maintained, migrated, and permanently retired within the Asveora system.

It operates as the deterministic lifecycle control layer over CIR-managed identity state.

All lifecycle transitions MUST pass through the Validation Architecture and Commit Lifecycle system before being reflected in the Registry State.

---

## 3.13.2 Purpose

The Identity Lifecycle system exists to:

* define valid identity state transitions
* govern onboarding of new identities into CIR
* enforce lifecycle consistency across federation instances
* coordinate migration between Network Instances
* ensure deterministic identity retirement (tombstoning)
* integrate lifecycle transitions with validation and commit pipelines

It answers:

> “How does an identity safely enter, evolve, and exit the Asveora system?”

---

## 3.13.3 Lifecycle Authority Model

Identity lifecycle is NOT self-determined by identities.

Lifecycle authority is governed by:

1. Validation Architecture (03-05)
2. Commit Lifecycle Execution (commit-lifecycle.schema.json)
3. CIR state machine (identity_state)
4. Local Network Instance enforcement

> Identity state is always an outcome of validation + commit, never a self-declared property.

---

## 3.13.4 Core Identity States

Defined in CIR schema:

* INITIATED
* VERIFIED
* VALIDATED
* ACTIVE
* SUSPENDED
* MIGRATING
* TOMBSTONED

These states form a **strict finite state machine**.

---

## 3.13.5 Valid State Transitions

### Allowed transitions:

* INITIATED → VERIFIED
* VERIFIED → VALIDATED
* VALIDATED → ACTIVE
* ACTIVE → SUSPENDED
* ACTIVE → MIGRATING
* SUSPENDED → ACTIVE
* MIGRATING → ACTIVE (post-migration reconciliation)
* ANY → TOMBSTONED (terminal override)

### Terminal rule:

> TOMBSTONED is irreversible

Once reached:

* identity MUST NOT re-enter active lifecycle
* CIR record is immutable except for metadata annotation
* federation MUST treat identity as permanently invalid

---

## 3.13.6 Onboarding Process (Legacy Pipeline Model)

Identity onboarding follows deterministic steps:

### Step 1 — Identity Ingestion

Input identity data is received via:

* API layer
* federation event
* internal registry creation request

---

### Step 2 — Structural Validation

Validation Architecture enforces:

* PIK format correctness
* VSIG authenticity
* APA validity (if present)
* CIR schema compliance

Failure → REJECTED

---

### Step 3 — Commit Lifecycle Execution

Commit lifecycle stages execute:

* INGESTION
* STRUCTURAL_VALIDATION
* CIR_AUTHENTICITY_VERIFICATION
* FEDERATION_CONTEXT_CHECK
* POLICY_EVALUATION
* REGISTRY_PRE_COMMIT
* COMMIT_FINALIZATION

Only COMMITTED results proceed.

---

### Step 4 — CIR Registration

On success:

* CIR entry is created or updated
* identity_state is assigned (typically INITIATED → VERIFIED or VALIDATED)
* registry snapshot is updated

---

### Step 5 — Registry Projection

Identity becomes visible in Registry State based on:

* identity_state
* local instance rules
* deterministic projection rules

---

## 3.13.7 Onboarding Process (Asveora Social Join Flow — Canonical Model)

This section defines the **canonical user-facing onboarding protocol for asveora.social**, which is an instance-specific implementation of the lifecycle system.

All steps MUST still resolve through Validation Architecture (03-05) and CIR authority.

---

### Step 1 — Candidate PIK Selection (User-Side Input)

The user MAY:

* generate a 12-character PIK manually
* use a PIK generator tool
* propose a self-created identifier

Constraint:

> PIK is not valid until CIR acceptance.

Users are encouraged (but not required) to pre-check availability via registry query.

---

### Step 2 — CIR Collision Verification (Authoritative Gate)

The submitted PIK is checked against CIR:

* uniqueness verification
* collision detection
* tombstone conflict check

Outcomes:

* ACCEPT → eligible for registration pipeline
* REJECT → user must select new PIK

Constraint:

> CIR is the sole authority for PIK acceptance.

---

### Step 3 — Wheelcore Assignment & APA Issuance

Upon acceptance into a Wheelcore:

* user is assigned a Wheelcore instance
* APA is issued in the form:

```
username.wheelcorename.xyz
```

This APA becomes the routing layer for identity resolution.

---

### Step 4 — Profile Space Binding

User binds APA to a Profile Space:

Two modes exist:

**Rich Deployment (RD):**

* user hosts full Profile Space (external website)
* APA points to user-controlled URL

**Quick Deployment (QD):**

* Wheelcore deploys hosted profile
* structure:

```
residents.wheelcorename.xyz/username.html
```

Constraint:

> APA MUST resolve to a valid Profile Space endpoint.

---

### Step 5 — RGBSIG Generation (Non-Authoritative Presence Layer)

User extracts RGB values from avatar image:

Format:

```
255000000-000255000-000000255
```

Properties:

* manually derived (human verification factor)
* NOT used in identity validation
* NOT part of CIR or VSIG logic
* purely presence + representational metadata

Constraint:

> RGBSIG MUST NOT be used in authentication, validation, or CIR processing.

---

### Step 6 — AUID Partial Submission (Verification Challenge Phase)

User enters Matrix-based verification room using PIK as username.

User submits partial AUID:

```text
[APA]=[PIK]
```

Rules:

* VSIG is NOT yet issued
* RGBSIG is NOT included
* AER is NOT used in validation
* only structural identity components are evaluated

Constraint:

> AUID submission is validation input, not identity confirmation.

---

### Step 7 — CIR Finalization & VSIG Issuance

Upon successful validation:

* CIR entry is created or finalized
* identity_state updated (VERIFIED → VALIDATED or ACTIVE depending on policy)
* VSIG is generated

VSIG is delivered via:

* encrypted Matrix DM
* verified via Matrix UVS (User Verification Service)

Analogy:

> Equivalent to issuing 2FA recovery codes after authentication enrollment.

Constraint:

> VSIG MUST NEVER be publicly exposed or included in Profile Spaces.

---

### Step 8 — Identity Activation

After VSIG issuance:

* full AUID becomes resolvable:

```text
[APA]=[PIK]-[VSIG]
```

Identity is now:

* CIR-backed
* validation-complete
* federation-resolvable

---

## 3.13.8 Migration Model

(Migration rules unchanged)

---

## 3.13.9 Suspension Model

(Same as original)

---

## 3.13.10 Tombstoning (Identity Termination)

(Same as original)

---

## 3.13.11 Federation Interaction

(Same as original)

---

## 3.13.12 Determinism Requirement

(Same as original)

---

## 3.13.13 Relationship to Other Systems

### Depends on:

* Validation Architecture (03-05)
* CIR schema
* commit-lifecycle.schema.json
* Federation Protocol

### Feeds into:

* Registry System
* Trust Model
* API Layer

---

## 3.13.14 Summary

The Identity Lifecycle and Onboarding system defines the deterministic evolution of identity within Asveora.

It ensures:

* strict state machine enforcement
* validation-gated onboarding
* controlled migration between instances
* irreversible termination semantics
* federation-aware but locally enforced transitions

Identity lifecycle is always an outcome of validation and commit execution, never independent identity action.
