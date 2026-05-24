## 1.4.1 Scope

This RFC defines the canonical protocol architecture, identity systems, federation mechanisms, governance semantics, registry models, and operational expectations of the **Ecosystem**. The scope of this specification is intentionally constrained to protocol-layer responsibilities required for deterministic interoperability between independent implementations and sovereign **Network**. Asveora is not defined as a monolithic application platform. Instead, it functions as a foundational identity and federation substrate upon which heterogeneous runtime systems MAY be constructed.

## 1.4.2 In-Scope Components

The following components are considered within the normative scope of this RFC. They are listed in the order of component dependency and layer representation of inheritance. Please do not reorder this list of concepts in any model or diagram.

### Identity Architecture

Defines **PIK (Primary Identity Key)**, **VSIG (Verification Signature)**, **APA (Asveora Profile Address)**, **AUID (Asveora Unified Identity Descriptor)**, **CIR (Canonical Identity Record)**, identity lifecycle states, identity migration semantics, and identity validation behavior.

### Registry Systems

Defines canonical registry structures, identity record synchronization, validation requirements, registry consistency expectations, deterministic identity state evaluation, and registry trust assumptions.

### Federation Architecture

Defines the interoperability of Networks, federation synchronization mechanisms, federation trust coordination, federation topology expectations, synchronization behaviors, and federation validation requirements.

### Governance and Trust Systems

Defines governance signaling models, instance sovereignty expectations, trust evaluation semantics, federation-level trust coordination, access control concepts, and operational governance boundaries.

### Operational Models

Defines deployment expectations, instance lifecycle states, migration behavior, federation operational models, synchronization consistency requirements, and runtime interoperability assumptions (which we will need to keep a watchful eye on as the Ecosystem expands).

### Security Considerations

Defines identity validation assumptions, trust boundaries, federation attack considerations, registry integrity expectations, verification security requirements, and operational threat surfaces (of which there are many).

## 1.4.3 Out-of-Scope Components

The following systems and behaviors are explicitly outside the normative scope of this RFC and should not be addressed anywhere within it. These systems and behaviors are covered either by the Asveora Constitution, the Asveora User Handbook, or within Asveora’s ever-expanding library of guidance wikis (which are updated more frequently than the other two items and this RFC). The RFC does not define the following categories of topics:

### Application-Layer Social Systems

Such as comments, reactions, like systems, repost/reshare systems, follower systems, recommendation algorithms, engagement ranking systems, or social graph implementations. These systems MAY operate on top of Asveora primitives but remain application-specific concerns.

### Frontend Rendering and UI Behavior

Such as frontend layouts, visual themes, rendering engines, interface conventions, design systems, presentation logic, and client-side UX behavior. Implementations MAY independently define user experience behavior provided canonical protocol semantics remain intact. A good rule of thumb is to reference the Web Content Accessibility Guidelines (WCAG) created by the World Wide Web Consortium (W3C) to ensure a more accessible digital landscape for those with disabilities. Please see those guidelines at: [https://www.wcag.com](https://www.wcag.com)

### Marketplace and Commerce Systems

Such as payment systems, storefront logic, transaction processors, digital commerce behavior, marketplace ranking systems, escrow systems, and monetization mechanisms. Such systems MAY integrate with Asveora identity and federation primitives but remain external to the protocol specification.

### Embedded Runtime Applications

Such as widget systems, embedded applications, third-party runtime containers, external service integrations, application execution environments, and plugin architectures. To clarify, an application execution environment is simply the location where the application runs. This could be locally within a Desktop Environment (meaning your operating system’s local environment that requires no internet connection) or remotely on an external server over the web (which means you need an internet connection). Runtime environments MAY use Asveora identity and federation primitives without becoming part of the canonical protocol itself. However, the same foundational rules apply about whether you are intending to be a part of the Asveora Ecosystem or not.

### Hosting Infrastructure Implementations

Such as specific programming languages, database engines, storage architectures, hosting providers, operating systems, deployment tooling, and infrastructure orchestration models. Implementations MAY choose any infrastructure stack capable of satisfying normative protocol behavior, including databases, but the Asveora framework does not require databases in the traditional sense to operate. There are no databases that are “native” to Asveora and anyone claiming that there is or telling you need to “login” or request access to a specific database that is “universal” to Asveora is lying to you and potentially scamming you.

## 1.4.4 Protocol Boundary Principle

Asveora intentionally separates protocol-layer responsibilities from application-layer behavior. While the protocol defines identity semantics, federation semantics, registry consistency, governance coordination, trust evaluation, and interoperability requirements, it does not define how applications choose to utilize these primitives and never should be used to. This distinction was built into Asveora in order to preserve the aforementioned characteristics of implementation flexibility, ecosystem extensibility, deployment sovereignty, long-term protocol stability, and runtime experimentation freedom without running the risk of compromising canonical federation behavior.

## 1.4.5 Wheelcore and Infrastructure Context

**Wheelcores** provide organizational and hosting environments within which **Profile Spaces** and runtime systems MAY exist. Wheelcores MAY belong to Networks, participate in federation ecosystems, host application-layer systems, and provide operational infrastructure. However, Wheelcores are not themselves identity primitives and do not inherently define identity validity or continuity. Please be aware that identity continuity remains governed exclusively through canonical identity and registry systems defined by this RFC.

## 1.4.6 Compliance Expectations

A system claiming compliance with this RFC MUST implement all normative protocol behaviors required for identity validation, registry consistency, federation interoperability, governance semantics, trust coordination, and lifecycle management. Systems MAY extend functionality beyond this specification provided such extensions do not violate canonical protocol behavior or compromise interoperability with compliant implementations. Don’t make the rest of us tap the sign.

## 1.4.7 Scope Summary

In summary, this RFC defines the constitutional identity layer of Asveora, federation interoperability semantics, registry and trust coordination systems, and operational protocol behavior while intentionally excluding application-specific runtime logic, UI and frontend conventions, platform-specific social mechanics, and implementation-specific infrastructure choices. This separation is fundamental to the long-term stability, extensibility, and interoperability goals of the Asveora Ecosystem. You may have heard this line several times already, but we want to make sure that this point is driven home to a deep extent through repetition.
