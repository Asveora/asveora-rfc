## 2.7.1 Deployment Model

The Asveora deployment model defines how the protocol is instantiated, hosted, and operated across independent systems. It describes the structural relationship between Networks, Wheelcores, and runtime environments, and establishes how decentralized deployment is achieved without reliance on centralized infrastructure.

Asveora is explicitly designed to support heterogeneous deployment environments while preserving deterministic protocol behavior and interoperability across all compliant systems. Deployment variation is permitted at the infrastructure level, but never at the level of protocol semantics.

## 2.7.2 Deployment Overview

An Asveora deployment is centered around a Network, which functions as the sovereign operational unit of the protocol. Each Network runs an independent instance of the Asveora protocol stack, maintains its own identity registry, enforces its own governance rules, and may optionally participate in federation with other Networks.

A Network also hosts one or more Wheelcores, which provide structural organization for identity-linked runtime environments. A deployment MAY consist of a single isolated Network or multiple interconnected Networks forming a federated ecosystem. In both cases, the Network remains the fundamental unit of operational independence.

## 2.7.3 Network as Deployment Unit

The Network is the smallest complete deployment unit in Asveora. It encapsulates all required systems for independent operation, including the identity registry system, federation interface layer, governance configuration, validation and VSIG issuance mechanisms, lifecycle management logic, and synchronization infrastructure.

A Network MUST be capable of operating in full isolation without reliance on external instances. Federation is therefore an optional coordination layer rather than a structural dependency.

## 2.7.4 Wheelcore Hosting Layer

Wheelcores operate as structural hosting and organizational units within a Network. They provide contextual runtime environments for identity-linked systems, including the hosting of Profile Spaces resolved through APA-based identity resolution, and the organization of application-layer constructs associated with identities.

Wheelcores do not exist as independent protocol entities. They remain fully subordinate to the Network boundary and MUST operate exclusively within it. Their role is structural and organizational rather than authoritative.

## 2.7.5 Deployment Topologies

Asveora supports multiple deployment topologies, each reflecting different operational configurations while preserving identical protocol semantics.

In a single-instance deployment, a Network operates in complete isolation without federation. In this configuration, the identity registry is self-contained, no external synchronization occurs, and governance remains entirely local.

In a federated deployment, multiple Networks interconnect through protocol-defined federation mechanisms. This enables synchronized identity exchange, cross-instance validation, distributed trust relationships, and independent governance across participating Networks.

A hybrid deployment combines isolated and federated instances, allowing selective synchronization scopes, conditional trust relationships, and partial federation participation depending on configuration and policy constraints.

## 2.7.6 Infrastructure Independence Principle

Asveora explicitly decouples protocol behavior from infrastructure implementation. A compliant deployment MAY be hosted on traditional server environments, distributed cloud systems, edge computing nodes, containerized systems, or fully self-hosted infrastructure.

However, infrastructure choice MUST NOT influence protocol semantics. Identity validation, federation behavior, and registry correctness MUST remain consistent regardless of hosting environment. The protocol defines behavior; infrastructure only provides execution context.

## 2.7.7 Stateless and Stateful Components

Within a deployment, system components are divided into stateless and stateful responsibilities.

Stateless components include federation request handlers, identity query interfaces, and API gateways. These components process and relay information but MUST NOT store authoritative identity state.

Stateful components include the identity registry system (CIR storage), lifecycle state tracking mechanisms, VSIG validation records, and federation synchronization logs. These components maintain canonical identity truth and are responsible for ensuring deterministic state reconstruction.

## 2.7.8 Deployment Synchronization Model

In federated environments, Networks MAY synchronize identity registry updates, lifecycle transitions, migration events, tombstone signals, and verification updates. All synchronization MUST follow deterministic protocol rules and MUST NOT introduce conflicting identity states across instances.

Synchronization is therefore a convergence mechanism rather than a source of truth generation.

## 2.7.9 Scalability Model

Scalability in Asveora is achieved through horizontal expansion of Networks rather than centralized system scaling. New Networks may be added, federation relationships may expand, registry load may be distributed, and validation responsibilities may be decentralized across instances.

This ensures that system growth occurs through structural distribution rather than vertical scaling of centralized components.

## 2.7.10 Deployment Isolation Principle

Each Network MUST remain operationally independent. Failure in one instance MUST NOT invalidate other instances, and registry corruption MUST remain contained within the affected Network boundary. Federation partitions MAY occur without compromising global system integrity, and identity systems MUST remain locally verifiable even in isolation.

Isolation is therefore treated as a fundamental resilience mechanism rather than a failure mode.

## 2.7.11 Upgrade and Versioning Model

Deployments MAY operate across different RFC versions provided that identity primitives remain compatible and federation protocols preserve interoperability guarantees. Registry structures MUST support backward compatibility where required.

Networks MAY upgrade independently, but federation interactions MUST include version negotiation to ensure continued compatibility across heterogeneous deployments.

## 2.7.12 Summary

The Asveora deployment model defines a decentralized, instance-based architecture in which each Network functions as a sovereign deployment unit capable of independent operation and optional federation.

It ensures that deployments remain infrastructure-agnostic, identity systems remain portable and consistent, federation remains optional but standardized, scalability is achieved through decentralization, and system resilience is preserved through strict instance isolation.

This model establishes Asveora as a distributed protocol ecosystem rather than a centralized application platform.
