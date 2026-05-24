### 3.4.1 VSIG – Verifiable Signature

The VSIG (Verifiable Signature) is a cryptographically derived verification token bound to a PIK (Primary Identity Key) once an identity has successfully completed registration and verification within a Network. It functions as the canonical proof that a given identity has been accepted into a Network’s authoritative registry, and it anchors that acceptance in a form that can be consistently validated across federation boundaries.

A VSIG is explicitly network-bound, meaning its issuance is always attributable to the Network that generated it. This binding is essential for maintaining deterministic provenance in federated environments, where identity verification must remain traceable without collapsing into centralized authority.

### 3.4.2 Structure and Components

A VSIG is composed of three conceptual parts: a string-type identifier indicating the token class, a unique verification code, and a network binding that identifies the issuing Network. These components are structured for both machine parsing reliability and human readability, ensuring that verification artifacts remain inspectable without requiring opaque decoding layers.

An example of a network-bound VSIG is:

```
vsig^%12345678901234567890^%nw@asveora.social
```

In this structure, the leading identifier establishes the token type as a VSIG, the central segment represents the unique 20-digit verification code generated at issuance time, and the final segment encodes the Network domain responsible for issuing the verification. Together, these elements form a verifiable linkage between identity, issuance event, and infrastructural origin.

### 3.4.3 Purpose and Use

The VSIG exists to provide both human-verifiable and system-verifiable confirmation that a PIK has been successfully registered within a Network’s CIR-backed identity system. It is used as a validation anchor in identity resolution, federation exchange, and registry enforcement processes, ensuring that identity claims can be consistently grounded in verified issuance events.

Within operational systems, the VSIG supports registration confirmation, identity validation workflows in resolvers and registry systems, and safeguards against the propagation of unverified or malformed identity states across federation boundaries.

VSIGs are non-reusable and are uniquely assigned per PIK–Network pairing. In cases where multiple AUIDs exist within the same Network, all associated VSIGs must remain available for auditability and governance integrity, ensuring that identity multiplicity cannot be exploited for manipulation within civic or trust-sensitive systems.

### 3.4.4 Lifecycle States

VSIGs participate in the broader identity lifecycle through a defined set of resolvable states within the validation and registry system. These states describe the verification status of an identity binding and are interpreted consistently across all compliant systems.

| State      | Meaning                                       |
| ---------- | --------------------------------------------- |
| VALID      | Identity is fully verified and compliant      |
| INVALID    | Identity fails structural or trust validation |
| UNKNOWN    | Identity cannot be resolved within CIR        |
| MIGRATING  | Identity is undergoing coordinated transition |
| TOMBSTONED | Identity has been permanently invalidated     |

All systems interacting with VSIGs MUST interpret these states deterministically, ensuring that federation and registry behavior remains consistent across distributed environments.

### 3.4.5 References

* Section 3.2 – PIK: foundational identity anchor
* Section 3.3 – APA: resolution and routing layer
* Section 3.5 – RGBSIG: non-authoritative expressive metadata
* Section 3.6 – AUID: composite resolvable identity structure
