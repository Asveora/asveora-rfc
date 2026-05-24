## 3.2.1 PIK (Primary Identity Key)

The Primary Identity Key (PIK) is the foundational authoritative identity primitive within the Asveora ecosystem. It functions as the persistent identity anchor from which identity continuity, registry uniqueness, validation determinism, and federation-safe portability are derived across distributed Networks.

The PIK is the root identifier upon which all higher-level identity structures are constructed.

---

## 3.2.2 Purpose

The PIK exists to establish persistent identity continuity, provide deterministic identity anchoring, enforce uniqueness within registry systems, support portable federation-safe identity behavior, and serve as the authoritative root identity primitive.

It answers a single question: what is the persistent authoritative identity anchor for an entity?

---

## 3.2.3 Identity Role

The PIK represents the canonical root identity reference for an entity and exists as authoritative identity state rather than presentation state.

A PIK uniquely identifies an identity record, remains independent from infrastructure location, survives migration between Networks, and remains stable across runtime state changes. It forms the foundational component of the APC (Authoritative Profile Core).

---

## 3.2.4 Canonical Structure

The PIK exists as part of the APC structure:

```
[PIK]-[VSIG]
```

Within this structure, the PIK serves as the persistent identity anchor while the VSIG provides verification and authenticity validation.

The PIK MUST NOT be interpreted independently of registry validation systems.

---

## 3.2.5 Registry Relationship

All PIKs are maintained within CIR (Canonical Identity Record) systems, which provide authoritative registry control.

The CIR is responsible for enforcing PIK uniqueness, managing identity lifecycle state, handling tombstoning, coordinating migration reconciliation, and maintaining validation state consistency. It is the authoritative source of PIK validity.

---

## 3.2.6 Deterministic Identity Principle

PIKs MUST behave deterministically across all compliant systems.

Given identical inputs and registry state, a valid PIK MUST resolve consistently. Federation systems MUST interpret PIKs identically, and infrastructure relocation MUST NOT alter PIK correctness. Determinism is required for interoperability and federation trust.

---

## 3.2.7 Persistence Requirements

A PIK represents persistent identity continuity across time and infrastructure.

A valid PIK MUST survive runtime restarts, application-layer changes, Wheelcore migration, and federation synchronization processes. It remains stable independently of infrastructure context.

---

## 3.2.8 Infrastructure Independence

PIKs are explicitly decoupled from Networks and infrastructure metadata.

A PIK MUST NOT contain instance identifiers, hosting environment data, federation attachment state, or infrastructure location information. This ensures identity portability, migration safety, and infrastructure neutrality.

Identity authority remains structurally separate from infrastructure location.

---

## 3.2.9 Relationship to APA

The PIK does not define resolution behavior. Resolution is handled through APA (Asveora Profile Address), which operates within the AUID structure.

```
[APA]=[PIK]-[VSIG]
```

In this relationship, the APA provides routing and resolution, while the PIK provides identity authority. The PIK is identity, not routing.

---

## 3.2.10 Relationship to RGBSIG

The PIK is fully independent from presentation metadata.

It MUST NOT be influenced by RGBSIG, avatar state, profile styling, or any expressive rendering system. Presentation systems remain strictly isolated from identity authority.

---

## 3.2.11 Federation Behavior

Federation systems MAY validate PIK existence, synchronize registry state, reconcile migration events, and verify tombstoning status.

However, federation systems MUST NOT mutate foreign PIK authority, redefine PIK correctness, or override local CIR validation. PIK authority remains local to the CIR that defines it.

---

## 3.2.12 Lifecycle States

A PIK MAY exist in several lifecycle states:

| State       | Meaning                       |
| ----------- | ----------------------------- |
| Active      | Valid and registry-recognized |
| Migrating   | Under coordinated migration   |
| Tombstoned  | Permanently retired           |
| Invalidated | Validation integrity failed   |

Lifecycle state is managed exclusively through CIR systems.

---

## 3.2.13 Tombstoning Behavior

A tombstoned PIK MUST NOT be reassigned and MUST remain permanently reserved within the registry system. It MAY remain visible for historical reconciliation but is permanently invalid for future issuance.

Tombstoning preserves identity continuity integrity.

---

## 3.2.14 Security Characteristics

The PIK is security-sensitive identity infrastructure and therefore requires strict enforcement guarantees.

PIK uniqueness MUST be enforced, unauthorized mutation MUST be prohibited, and registry reconciliation MUST remain deterministic. Validation MUST remain CIR-backed, and the PIK alone does not establish trust.

Trust requires VSIG validation and CIR verification.

---

## 3.2.15 Validation Rules

PIK validation MUST include registry existence checks, tombstone verification, lifecycle state verification, and APC integrity validation.

Validation outcomes MUST remain deterministic across all compliant implementations.

---

## 3.2.16 Relationship to Other Components

The PIK directly interacts with VSIG, APC, AUID, CIR systems, federation validation layers, access control systems, and migration systems.

All authoritative identity structures ultimately depend upon the PIK.

---

## 3.2.17 Implementation Constraints

Compliant implementations MUST preserve PIK immutability, maintain deterministic validation behavior, isolate PIK authority from presentation systems, and prevent infrastructure-coupled identity behavior.

Implementations MAY vary internally as long as protocol correctness is preserved.

---

## 3.2.18 Summary

The PIK is the foundational authoritative identity anchor within the Asveora ecosystem.

It provides persistent identity continuity, deterministic validation behavior, federation-safe portability, registry-backed authority, and infrastructure-independent identity existence.

The PIK serves as the root primitive upon which all higher-level identity systems are constructed.
