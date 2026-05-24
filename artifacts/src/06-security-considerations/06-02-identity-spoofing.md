## 1. Purpose

This document defines the threat model, attack surfaces, detection constraints, and mitigation requirements related to identity spoofing within the Asveora system.

Identity spoofing refers to:

> Any attempt to impersonate, fabricate, replay, substitute, or misleadingly represent identity state outside deterministic identity validation constraints.

This specification governs:

* AUID impersonation
* APC forgery attempts
* VSIG substitution attacks
* detached identity replay
* federation identity impersonation
* API-level identity misrepresentation



## 2. Core Principle

Identity within Asveora is derived exclusively from validated identity state.

Therefore:

> No identity representation is authoritative unless deterministically derived from valid CIR-backed identity state and successfully verified through schema-governed evaluation.

Key implication:

* representation alone does not establish identity legitimacy



## 3. Identity Spoofing Definition

Identity spoofing includes any condition where:

* an invalid identity appears structurally valid
* a detached identity is treated as authoritative
* a substituted APC is accepted as legitimate
* a forged or replayed VSIG is accepted
* an identity bypasses deterministic validation order
* exposure state is mistaken for ownership or authority



## 4. Protected Identity Components

The following components are considered spoof-sensitive:

| Component | Security Role                        |
|  |  |
| CIR       | Root identity truth                  |
| APA       | Address binding                      |
| PIK       | Primary identity integrity component |
| VSIG      | Verification integrity component     |
| APC       | Identity binding structure           |
| AUID      | External unified identity descriptor |

Compromise or impersonation of any component MUST invalidate downstream identity trust.



## 5. Identity Spoofing Threat Categories

Identity spoofing threats are classified as:

```text id="spoof_categories"
STRUCTURAL_SPOOFING
VERIFICATION_SPOOFING
DETACHED_SPOOFING
FEDERATION_SPOOFING
EXPOSURE_SPOOFING
REPLAY_SPOOFING
```



## 6. Threat Definitions

### 6.1 STRUCTURAL_SPOOFING

Definition:

> Fabrication of identity structures that mimic valid AUID/APC syntax without valid derivation.

Examples:

* fake AUID formatting
* forged APC structures
* malformed identity substitution

Constraint:

> Structural correctness alone MUST NEVER imply validity.



### 6.2 VERIFICATION_SPOOFING

Definition:

> Attempt to bypass or falsify VSIG verification state.

Examples:

* forged VSIG
* replayed VSIG
* substituted verification payloads

Constraint:

> VSIG validity MUST always be independently evaluated.



### 6.3 DETACHED_SPOOFING

Definition:

> Use of identity fragments outside valid CIR association.

Examples:

* orphaned APC reuse
* detached APA references
* stale AUID replay

Constraint:

> Detached identity state MUST NOT inherit validity.



### 6.4 FEDERATION_SPOOFING

Definition:

> Impersonation of federated identity state across trust boundaries.

Examples:

* cross-node identity injection
* federation-origin spoofing
* remote trust escalation

Constraint:

> Federation MUST NOT imply identity authenticity without local validation.



### 6.5 EXPOSURE_SPOOFING

Definition:

> Abuse of exposed identity representations to imply authority or ownership.

Examples:

* public AUID impersonation
* indexed identity replay
* API-derived identity misuse

Constraint:

> Exposure state MUST NOT be interpreted as proof of authority.



### 6.6 REPLAY_SPOOFING

Definition:

> Reuse of previously valid identity material outside valid evaluation state.

Examples:

* replayed migration tokens
* stale authorization bindings
* expired federation identity reuse

Constraint:

> Temporal validity MUST be enforced deterministically.



## 7. Identity Validation Requirements

All identity representations MUST undergo:

```text id="spoof_validation"
STRUCTURAL_VALIDATION
SCHEMA_VALIDATION
VSIG_VALIDATION
REGISTRY_VALIDATION
FEDERATION_VALIDATION
EXPOSURE_VALIDATION
```

Failure at any stage MUST invalidate identity legitimacy.



## 8. Validation Ordering Constraints

Identity validation MUST occur in deterministic order:

```text id="spoof_order"
CIR Resolution
    ↓
APC Validation
    ↓
VSIG Verification
    ↓
AUID Integrity Evaluation
    ↓
Authorization Evaluation
    ↓
Exposure Evaluation
```

Constraint:

> Downstream systems MUST NOT bypass upstream identity validation stages.



## 9. CIR Protection Rules

Because CIR is the authoritative identity origin:

* CIR MUST NOT be spoofable through exposed representations
* CIR MUST remain non-reconstructable
* CIR resolution MUST remain local-authoritative
* CIR substitution attempts MUST fail closed

Key rule:

> No externally visible identity state may supersede CIR authority.



## 10. APC and AUID Spoofing Constraints

### 10.1 APC Integrity Requirements

APC:

```text id="apc_format"
[PIK]-[VSIG]
```

Requirements:

* PIK MUST resolve to valid identity state
* VSIG MUST validate against current schema constraints
* APC MUST remain bound to valid CIR lineage



### 10.2 AUID Integrity Requirements

AUID:

```text id="auid_format"
[APA]=[PIK]-[VSIG]
```

Requirements:

* APA MUST resolve correctly
* APC MUST validate completely
* detached AUID reuse MUST fail validation



## 11. Federation Spoofing Constraints

Federated identity systems MUST:

* independently validate incoming identity state
* reject implicit trust inheritance
* reject unverifiable remote APC structures
* reject unresolved VSIG chains

Constraint:

> Federation synchronization MUST NOT bypass local validation authority.



## 12. Exposure and Indexing Risks

From Section 5:

* exposure does not imply legitimacy
* indexing does not imply authority
* visibility does not imply ownership

Therefore:

* indexed AUIDs MUST remain verification-dependent
* API-visible identities MUST remain non-authoritative until validated
* obfuscated identities MUST NOT gain implicit trust



## 13. Replay Resistance Requirements

Replay protection MUST include:

* temporal validation
* registry-state consistency checks
* federation freshness validation
* migration state verification
* revocation awareness

Expired or invalidated identity material MUST resolve to:

* DENIED
* RESTRICTED
* or SUPPRESSED



## 14. Detection Requirements

Implementations SHOULD detect:

* repeated VSIG mismatches
* anomalous federation identity reuse
* structurally valid but unresolved AUIDs
* detached APC usage patterns
* replayed migration identity flows
* index correlation anomalies

Detection systems MUST NOT override deterministic enforcement outcomes.



## 15. Security Constraints

The system MUST ensure:

* identity legitimacy requires deterministic validation
* exposed identity is never inherently authoritative
* spoof-resistant evaluation precedes exposure
* federation cannot amplify spoofed trust
* detached identity state cannot regain authority independently

Security principle:

> Identity validity is derived, not asserted.



## 16. Failure Behavior

The following failures MUST resolve toward restriction:

| Failure Type        | Result      |
| - | -- |
| Invalid VSIG        | DENIED      |
| Unresolved CIR      | SUPPRESSED  |
| Detached APC        | RESTRICTED  |
| Federation mismatch | CONFLICTED  |
| Replay detection    | INVALIDATED |
| Schema mismatch     | FAIL-CLOSED |



## 17. System Invariants

The following MUST always hold:

* CIR remains authoritative identity truth
* APC validity depends on VSIG integrity
* AUID validity depends on APC legitimacy
* exposure cannot establish ownership
* federation cannot establish authenticity independently
* replayed identity state cannot regain validity automatically
