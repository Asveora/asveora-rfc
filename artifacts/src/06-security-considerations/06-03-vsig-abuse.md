## 1. Purpose

This document defines the threat model, abuse scenarios, integrity constraints, and mitigation requirements related to misuse or compromise of the VSIG component within the Asveora identity system.

VSIG is a foundational identity integrity primitive.

Therefore:

> Compromise, forgery, replay, substitution, or misuse of VSIG threatens the validity of APC, AUID, and all downstream identity evaluation systems.

This specification governs:

* forged VSIG structures
* replayed VSIG usage
* detached VSIG reuse
* stale verification state
* federation VSIG abuse
* verification bypass attempts
* VSIG substitution attacks



## 2. Core Principle

VSIG is an integrity-verification component, not an identity representation layer.

Therefore:

> VSIG validity establishes verification continuity, not identity ownership independently.

Key implication:

* a structurally valid VSIG is not inherently trustworthy
* VSIG authority depends on deterministic validation context



## 3. VSIG Definition

VSIG is defined as:

```text id="vsig_def"
VSIG = Verification Signature
```

VSIG participates in APC formation:

```text id="apc_format"
APC = [PIK]-[VSIG]
```

And therefore contributes to AUID formation:

```text id="auid_format"
AUID = [APA]=[PIK]-[VSIG]
```

Constraint:

> VSIG is inseparable from deterministic validation state.



## 4. Protected Security Properties

VSIG is responsible for preserving:

* verification integrity
* identity continuity
* anti-spoofing guarantees
* anti-replay guarantees
* federation verification consistency
* APC validity
* AUID legitimacy

Failure of VSIG integrity MUST invalidate all dependent identity structures.



## 5. VSIG Abuse Categories

VSIG abuse threats are classified as:

```text id="vsig_categories"
FORGED_VSIG
REPLAYED_VSIG
DETACHED_VSIG
SUBSTITUTED_VSIG
STALE_VSIG
FEDERATION_VSIG_ABUSE
PARTIAL_DISCLOSURE_ABUSE
```



## 6. Threat Definitions

### 6.1 FORGED_VSIG

Definition:

> Fabricated VSIG intended to appear structurally or cryptographically valid.

Examples:

* synthetic signature generation
* malformed verification structures
* unauthorized verification creation

Constraint:

> Structural validity MUST NOT imply verification legitimacy.



### 6.2 REPLAYED_VSIG

Definition:

> Reuse of previously valid VSIG outside valid evaluation state.

Examples:

* expired identity replay
* stale APC reuse
* revoked verification reuse

Constraint:

> VSIG MUST remain temporally bound to active identity state.



### 6.3 DETACHED_VSIG

Definition:

> VSIG reused independently of its original APC/CIR lineage.

Examples:

* VSIG copied into unrelated APC
* orphaned verification reuse
* identity reassociation attempts

Constraint:

> VSIG MUST remain lineage-bound.



### 6.4 SUBSTITUTED_VSIG

Definition:

> Replacement of legitimate VSIG with attacker-controlled verification state.

Examples:

* APC manipulation
* verification replacement
* federation verification injection

Constraint:

> VSIG substitution MUST invalidate APC continuity.



### 6.5 STALE_VSIG

Definition:

> VSIG derived from outdated or superseded registry state.

Examples:

* outdated federation synchronization
* stale migration snapshots
* delayed registry propagation

Constraint:

> Stale VSIG MUST fail deterministic freshness validation.



### 6.6 FEDERATION_VSIG_ABUSE

Definition:

> Abuse of federated verification assumptions to bypass local validation.

Examples:

* remote trust injection
* unverifiable federation verification chains
* delegated VSIG impersonation

Constraint:

> Federation MUST NOT supersede local verification authority.



### 6.7 PARTIAL_DISCLOSURE_ABUSE

Definition:

> Exploitation of partially exposed VSIG fragments for inference or replay.

Examples:

* obfuscated VSIG correlation
* indexed verification reconstruction
* tokenized verification linkage attacks

Constraint:

> Partial disclosure MUST remain non-reconstructable.



## 7. VSIG Validation Requirements

VSIG evaluation MUST include:

```text id="vsig_validation"
STRUCTURAL_VALIDATION
SCHEMA_VALIDATION
LINEAGE_VALIDATION
REGISTRY_VALIDATION
TEMPORAL_VALIDATION
FEDERATION_VALIDATION
REVOCATION_VALIDATION
```

Failure at any stage MUST invalidate VSIG legitimacy.



## 8. Validation Ordering Constraints

VSIG validation MUST occur within deterministic identity evaluation order:

```text id="vsig_order"
CIR Resolution
    ↓
PIK Validation
    ↓
VSIG Validation
    ↓
APC Integrity Validation
    ↓
AUID Evaluation
    ↓
Authorization Evaluation
```

Constraint:

> VSIG MUST NOT be evaluated independently of identity lineage.



## 9. APC Integrity Dependency

Because APC is formed as:

```text id="apc_vsig"
[PIK]-[VSIG]
```

The following MUST hold:

* invalid VSIG → invalid APC
* detached VSIG → restricted APC
* replayed VSIG → invalidated APC
* substituted VSIG → fail-closed APC

Constraint:

> APC legitimacy is impossible without valid VSIG continuity.



## 10. AUID Dependency Constraints

Since AUID incorporates APC:

```text id="auid_vsig"
[APA]=[PIK]-[VSIG]
```

The following MUST hold:

* invalid VSIG invalidates AUID legitimacy
* exposed AUID does not imply VSIG trustworthiness
* replayed AUID with stale VSIG MUST fail validation
* tokenized AUID MUST preserve VSIG non-reconstructability



## 11. Federation Verification Constraints

Federated systems MUST:

* independently validate VSIG integrity
* reject unverifiable remote VSIG state
* reject stale verification propagation
* reject delegated verification escalation
* preserve deterministic verification ordering

Constraint:

> Federation synchronization MUST NOT replace local VSIG validation.



## 12. Exposure and Indexing Constraints

From Section 5:

* VSIG exposure is restricted
* obfuscation is irreversible
* indexing is non-reconstructive

Therefore:

* exposed VSIG fragments MUST remain non-authoritative
* indexed verification state MUST remain detached from raw verification material
* partial VSIG disclosure MUST resist inference reconstruction



## 13. Replay Resistance Requirements

Replay resistance MUST include:

* temporal validation
* registry freshness enforcement
* migration-state verification
* revocation tracking
* federation consistency checks
* lineage continuity validation

Replay-detected VSIG state MUST resolve to:

* INVALIDATED
* DENIED
* or SUPPRESSED



## 14. Revocation Requirements

VSIG revocation MUST:

* propagate deterministically
* invalidate dependent APC structures
* invalidate dependent AUID structures
* prevent stale federation reuse
* prevent index persistence beyond revocation scope

Constraint:

> Revoked VSIG state MUST NOT regain authority through replay or federation synchronization.



## 15. Detection Requirements

Implementations SHOULD detect:

* repeated VSIG mismatches
* anomalous APC continuity changes
* stale verification reuse
* federation verification inconsistencies
* detached VSIG lineage patterns
* replayed verification sequences
* abnormal obfuscated verification correlations

Detection systems MUST NOT override deterministic validation outcomes.



## 16. Security Constraints

The system MUST ensure:

* VSIG legitimacy depends on CIR-backed validation
* VSIG cannot establish identity independently
* replayed VSIG cannot regain authority
* partial disclosure cannot enable reconstruction
* federation cannot amplify unverifiable verification state

Security principle:

> Verification integrity is contextual, lineage-bound, and non-transferable.



## 17. Failure Behavior

The following failures MUST resolve toward restriction:

| Failure Type        | Result      |
| - | -- |
| Forged VSIG         | DENIED      |
| Detached VSIG       | RESTRICTED  |
| Replay detection    | INVALIDATED |
| Stale verification  | FAIL-CLOSED |
| Federation mismatch | CONFLICTED  |
| Revoked VSIG        | SUPPRESSED  |
| Schema mismatch     | FAIL-CLOSED |



## 18. System Invariants

The following MUST always hold:

* VSIG validity depends on deterministic evaluation
* APC legitimacy depends on VSIG integrity
* AUID legitimacy depends on APC validity
* federation cannot independently validate VSIG authority
* replayed verification state cannot regain legitimacy
* exposed verification fragments cannot establish trust independently
