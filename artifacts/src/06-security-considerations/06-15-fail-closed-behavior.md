## 1. Purpose

This document defines the fail-closed behavior model for the Asveora system.

Fail-closed behavior refers to:

> A deterministic security posture in which any ambiguity, inconsistency, validation failure, integrity violation, or unresolved evaluation results in denial, suppression, or restriction of system output or operation.

This specification governs:

* system-wide failure resolution rules
* identity validation failure behavior
* registry and federation inconsistency handling
* exposure evaluation fallback logic
* API emission safety constraints
* operational and governance enforcement failure states



## 2. Core Principle

The system defaults to safety under uncertainty.

Therefore:

> If the system cannot conclusively determine a state as valid, authorized, and lifecycle-consistent, it MUST deny or suppress the operation.

Key implication:

* uncertainty is treated as invalidity



## 3. Fail-Closed Model Definition

Fail-closed behavior applies when:

* schema validation fails or is incomplete
* identity state cannot be fully resolved (CIR/APC/VSIG/AUID)
* registry state is inconsistent or stale
* authorization evaluation is inconclusive
* federation state is divergent or unverified
* exposure evaluation cannot deterministically conclude safety
* operational context is untrusted or corrupted

Constraint:

> Any unresolved evaluation MUST NOT result in partial or speculative output.



## 4. Protected Fail-Closed Properties

The system MUST preserve:

* deterministic denial behavior under ambiguity
* suppression of unsafe outputs
* prevention of partial identity exposure
* elimination of speculative authorization
* registry-consistent failure resolution
* federation-safe fallback behavior
* API emission safety guarantees

Compromise of fail-closed integrity MUST be treated as a critical security violation.



## 5. Fail-Closed Trigger Conditions

Fail-closed behavior is triggered by:

```text id="fail_closed_triggers"
SCHEMA_VALIDATION_FAILURE
IDENTITY_RESOLUTION_FAILURE
REGISTRY_INCONSISTENCY
AUTHORIZATION_AMBIGUITY
FEDERATION_DIVERGENCE
EXPOSURE_UNCERTAINTY
OPERATIONAL_UNTRUSTED_CONTEXT
RATE_LIMIT_OVERFLOW
MIGRATION_STATE_INCONSISTENCY
```



## 6. Failure Resolution Categories

All system failures MUST resolve into one of the following states:

### 6.1 DENIED

> Operation is explicitly rejected.

Used when:

* authorization fails
* identity is invalid
* schema violation is detected



### 6.2 SUPPRESSED

> Output is intentionally omitted to prevent exposure.

Used when:

* exposure risk is detected
* reconstruction risk exists
* partial identity state is observed



### 6.3 RESTRICTED

> Operation is partially allowed under constrained scope.

Used when:

* safe subset of operation is deterministically valid
* limited authorization exists



### 6.4 INVALIDATED

> Identity or state is declared non-authoritative.

Used when:

* registry mismatch occurs
* lifecycle state is broken
* detached identity is detected



### 6.5 CONFLICTED

> System cannot resolve authoritative state deterministically.

Used when:

* federation divergence exists
* concurrent state mismatch occurs
* migration inconsistency detected



## 7. System-Wide Fail-Closed Ordering

All evaluations MUST resolve failures in deterministic order:

```text id="fail_closed_order"
Schema Validation
    ↓
Identity Validation
    ↓
Registry Validation
    ↓
Authorization Evaluation
    ↓
Federation Consistency Check
    ↓
Exposure Evaluation (EDS)
    ↓
Operational Context Validation
    ↓
Final Decision (Emit / Suppress / Deny)
```

Constraint:

> Any failure at any stage MUST immediately propagate to fail-closed resolution.



## 8. Identity Fail-Closed Behavior

Identity failures include:

* CIR mismatch
* APC invalidation
* VSIG verification failure
* AUID resolution failure

Resolution:

* identity is marked INVALIDATED
* downstream exposure is SUPPRESSED
* authorization is DENIED

Constraint:

> No identity evaluation may degrade into probabilistic acceptance.



## 9. Registry Fail-Closed Behavior

Registry failures include:

* inconsistent state snapshot
* stale or replayed entries
* migration corruption
* partial writes

Resolution:

* registry state is treated as invalid
* all dependent identity states are suppressed
* system enters restricted evaluation mode if needed



## 10. Federation Fail-Closed Behavior

Federation failures include:

* node divergence
* synchronization mismatch
* remote trust inconsistency

Resolution:

* local state overrides remote state
* divergent federation data is ignored
* conflicting identities are suppressed

Constraint:

> Federation cannot override fail-closed decision logic.



## 11. Exposure Fail-Closed Behavior

Exposure evaluation failures include:

* inability to deterministically evaluate visibility
* reconstruction risk detection
* incomplete EDS resolution

Resolution:

* output is SUPPRESSED
* no partial exposure is allowed
* no fallback inference is permitted

Constraint:

> Exposure is either fully valid or fully suppressed.



## 12. API Fail-Closed Behavior

From Section 6-07:

* API is emission-only

Therefore:

* API MUST NOT emit uncertain or partially validated data
* API MUST suppress outputs under any ambiguity
* API MUST rely solely on upstream validated states



## 13. Operational Fail-Closed Behavior

Operational failures include:

* configuration inconsistency
* runtime poisoning
* governance mismatch
* unauthorized privilege attempts

Resolution:

* system enters restricted or denied state
* operations are blocked
* no partial execution allowed



## 14. Migration Fail-Closed Behavior

From Section 6-11:

* migration is atomic

Therefore:

* partial migration state is INVALIDATED
* failed migration MUST NOT produce visible state
* rollback inconsistencies trigger suppression



## 15. Rate Limiting Fail-Closed Behavior

From Section 6-12:

* rate limiting is deterministic

Therefore:

* exceeded limits result in DENIED
* ambiguous load conditions result in RESTRICTED or SUPPRESSED
* no adaptive bypass is permitted



## 16. Security Principle

Fail-closed behavior enforces:

> Safety through deterministic denial of uncertainty.

This ensures:

* no speculative system behavior
* no probabilistic identity inference
* no partial exposure leakage
* no inconsistent authorization states



## 17. System Invariants

The following MUST always hold:

* uncertainty resolves to denial or suppression
* no partial identity is ever emitted
* no ambiguous authorization is accepted
* federation cannot override local failure decisions
* registry inconsistency invalidates dependent state
* API cannot bypass fail-closed logic
* exposure is strictly binary (emit or suppress)
