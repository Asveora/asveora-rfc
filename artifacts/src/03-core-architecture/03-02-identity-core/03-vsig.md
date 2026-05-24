# 3.4 VSIG – Verifiable Signature

VSIG (Verifiable Signature) is a cryptographically derived token assigned to a PIK (Primary Identity Key) once a user successfully completes Network registration and verification procedures. It serves as the **proof of verification** that a user has been recognized by a particular Network within the federated Asveora ecosystem. 

VSIG is **network-bound**, meaning it is explicitly associated with the Network that issued it. This ensures that downstream systems, identity resolvers, and inter-network federation mechanisms can unambiguously trace the origin of the verification token.

## Structure and Components

A VSIG is composed of the following elements:

- **String-type identifier:** Denotes that this is a VSIG token.
- **Unique verification code:** A 20-digit numeric string generated at the time of successful registration.
- **Network binding:** The domain address of the Network issuing the VSIG, included to guarantee network association.

The delimiter symbols used in VSIGs are chosen for maximum parsing safety in code and human readability. An example of a network-bound VSIG is:

```

vsig^%12345678901234567890^%nw@asveora.social

```

Where:

- `vsig` → string-type identifier  
- `12345678901234567890` → unique verification code  
- `nw@asveora.social` → Network domain binding  

## Purpose and Use

The VSIG functions as a **human-verifiable** and **system-verifiable** marker that a PIK has been successfully registered with a Network. It is primarily used to:

1. Assert user registration status to internal systems and federated services.
2. Enable validation processes in identity resolvers and canonical registries.
3. Prevent misattribution or misuse of unverified identities across Network boundaries.

VSIG tokens are **non-reusable** and uniquely assigned per PIK–Network pairing. If a user creates multiple AUIDs within the same Network, all VSIGs must be disclosed to ensure **governmental and governance integrity** and prevent potential vote manipulation or identity misrepresentation within civic processes.

## Lifecycle States

VSIGs participate in the broader identity lifecycle as defined in the **Validation Output Model**. They resolve into one of the following states:

| State      | Meaning                                   |
| - | -- |
| VALID      | Identity is fully compliant               |
| INVALID    | Identity fails structural or trust checks |
| UNKNOWN    | Identity cannot be resolved in CIR        |
| MIGRATING  | Identity is in transition state           |
| TOMBSTONED | Identity is permanently invalidated       |

All systems must respect these states and interpret VSIGs consistently across federation and registration processes.



**References:**

- Section 3.2 – PIK: foundational user key  
- Section 3.3 – APA: profile address and context  
- Section 3.5 – RGBSIG: non-authoritative presence tokens  
- Section 3.6 – AUID: combined identity descriptor


