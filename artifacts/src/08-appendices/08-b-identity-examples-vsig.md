# VSIG Examples Across Networks

This document illustrates examples of multiple **VSIGs (Verification Signatures)** for a single user in the federated Asveora ecosystem. Each VSIG is unique to the network that issues it. The **APA** (Address Pointer Alias) is tied to the wheelcore the user joins, which is itself bound to a specific network. **PIKs** may carry across networks if they are available in the target network; otherwise, a new PIK must be issued.



## Human-Readable Example

| Network           | Wheelcore  | APA                   | PIK      | VSIG        |
| -- | - |  | -- | -- |
| asveora.social    | wheelcore1 | alice1.wheelcore1.xyz | PIK-A123 | VSIG-ASV001 |
| asveora.news      | wheelcore2 | alice2.wheelcore2.xyz | PIK-A123 | VSIG-NEW001 |
| asveora.community | wheelcore3 | alice3.wheelcore3.xyz | PIK-B456 | VSIG-COM001 |

**Notes:**

* Alice moved from `asveora.social` to `asveora.news`. She retained her PIK (`PIK-A123`) because it was available in the new network. Her APA changed to reflect the new wheelcore. A new VSIG was issued (`VSIG-NEW001`).
* When joining `asveora.community`, her preferred PIK (`PIK-A123`) was already taken, so she received a new PIK (`PIK-B456`) and a new VSIG (`VSIG-COM001`).



## Ecosystem Identity Diagram

```mermaid
flowchart TD
    subgraph Network1 [asveora.social]
        A[Wheelcore1]
        APA1[APA: alice1.wheelcore1.xyz]
        PIK1[PIK: PIK-A123]
        VSIG1[VSIG: VSIG-ASV001]
        A --> APA1 --> PIK1 --> VSIG1
    end

    subgraph Network2 [asveora.news]
        B[Wheelcore2]
        APA2[APA: alice2.wheelcore2.xyz]
        PIK2[PIK: PIK-A123]
        VSIG2[VSIG: VSIG-NEW001]
        B --> APA2 --> PIK2 --> VSIG2
    end

    subgraph Network3 [asveora.community]
        C[Wheelcore3]
        APA3[APA: alice3.wheelcore3.xyz]
        PIK3[PIK: PIK-B456]
        VSIG3[VSIG: VSIG-COM001]
        C --> APA3 --> PIK3 --> VSIG3
    end

    %% Connections showing network migration
    VSIG1 |Move| APA2
    VSIG2 |Move| APA3
```

**Key Points:**

* **VSIGs are network-bound**: They do not carry between networks.
* **APA changes with wheelcore**: APA reflects the wheelcore the user is part of, which is associated with a specific network.
* **PIKs are network-first-come-first-serve**: If the PIK is available in the new network, the user may retain it; otherwise, a new PIK is issued.
