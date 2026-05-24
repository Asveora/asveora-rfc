## 3.7.1 Network

A Network defines a sovereign execution boundary within the Asveora ecosystem in which identity resolution, validation, registry state, federation participation, and governance policies are deterministically applied. It functions as the smallest fully self-contained operational unit in which Asveora can execute consistently defined identity and state behavior.

A Network is not a service, not a node, and not a deployment artifact. It is a logically consistent system domain in which all identity and state operations are resolved under locally enforced execution rules derived from the global specification.

## 3.7.2 Instance as a Sovereign Execution Boundary

Each Network operates as an independently consistent and internally deterministic system while remaining externally federated without being externally controlled. It defines a strict execution boundary within which all core subsystems operate, including CIR storage and lifecycle execution, validation architecture enforcement, registry projection logic, federation interfaces, governance policy enforcement, and access control evaluation.

However, while a Network executes schema-defined rules, it does not define schema truth itself. Authority originates from the specification layer, while the instance serves as the deterministic execution environment for that specification.

## 3.7.3 Relationship to CIR (Identity Root)

All identity within a Network is anchored in CIR (Canonical Identity Record) structures. The instance is responsible for issuing or hosting CIR records, validating CIR consistency through the validation architecture, maintaining registry projections derived from CIR state, and enforcing lifecycle transitions over CIR entries. CIR represents the global structural definition of identity, while the Network represents the local execution context in which that definition is applied deterministically.

## 3.7.4 Instance State Model

A Network maintains a deterministic operational state composed of registry snapshots, active CIR sets, validation pipeline configurations, federation peer sets, governance policy versions, and access control configurations. This state is locally authoritative and reproducible under identical inputs, but it is not treated as a globally synchronized truth across the ecosystem.

## 3.7.5 Instance Isolation Principle

Networks MUST remain logically isolated from one another. No instance may directly modify another instance’s CIR set, override validation outcomes, inject cross-instance registry mutations, or alter governance state outside of its own boundary. Federation MAY transmit data between instances, but all incoming data MUST be treated as untrusted until it has been processed through the local validation architecture and resolved into deterministic state.

## 3.7.6 Deterministic Execution Requirement

Given identical inputs, including CIR state, registry state, validation configuration, governance policies, and federation inputs, a Network MUST produce identical outputs. This includes validation results, registry projections, lifecycle transitions, and federation reconciliation decisions. Determinism is a required property of execution rather than an emergent behavior.

## 3.7.7 Relationship to Core Architecture Layers

A Network functions as the execution container for multiple architectural layers without owning their definitions. These include CIR as the identity truth layer, the validation architecture as enforcement logic, the federation system as transport semantics, the registry system as projection layer, access control as decision logic, and governance as policy layer. The instance orchestrates execution across these layers but does not redefine their canonical behavior.

## 3.7.8 Federation Boundary Role

Within federation, a Network evaluates incoming FDEP data, applies local validation rules, resolves trust-weighted reconciliation outcomes, and updates registry projections accordingly. Federation defines transport semantics only, while execution, validation, and state reconciliation occur exclusively within the instance boundary. All federation input is external until validated locally through deterministic processing.

## 3.7.9 Failure Containment Model

When inconsistencies occur, failures are contained within the affected Network. Validation failures isolate impacted CIR operations, registry systems remain derived rather than corrupted, federation input is quarantined rather than executed, and governance remains stable unless explicitly redefined through versioned updates. Failure is treated as a local condition rather than a systemic propagation risk.

## 3.7.10 Security Boundary Role

The Network enforces security boundaries structurally by preventing invalid CIR propagation into registry systems, ensuring validation architecture remains authoritative, isolating federation-based trust manipulation attempts, and enforcing deterministic lifecycle transitions. Security is achieved through structural separation and deterministic enforcement rather than external policy reliance.

## 3.7.11 Summary

A Network is the sovereign execution container of the Asveora ecosystem. It provides deterministic identity execution context, isolated CIR lifecycle enforcement, registry derivation logic, federation interaction boundaries, governance application scope, and validation enforcement locality. It ensures that identity, state, and policy remain consistent within a bounded deterministic system while still enabling controlled federation across multiple instances.
