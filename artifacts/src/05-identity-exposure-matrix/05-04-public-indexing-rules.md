## 1. Purpose

This document defines the **Public Indexing Rules (PIR)** used by the Identity Exposure Matrix (IEM) to determine:

> Whether an identity-related element is eligible for inclusion in externally addressable indexing structures.

Public indexing refers to **structural inclusion in queryable or discoverable representations**, not raw data emission.

This layer governs whether identity-derived elements may participate in:

* API index responses
* Searchable metadata structures
* Cross-system reference graphs
* External discovery surfaces



## 2. Core Principle

Public indexing is not exposure.

Public indexing is:

> The determination of whether a data element may exist in a discoverable index structure, independent of its actual value exposure.

Key distinction:

* Exposure = visibility of data
* Indexing = discoverability of reference



## 3. Public Indexing Model

The Public Indexing Rules define a deterministic function:

```id="5q7k3p"
PI: IVL × SchemaConstraints × AuthorizationContext → IndexEligibilityState
```

Where:

* IVL = Identity Visibility Level (from 05-03)
* SchemaConstraints = machine-enforced structural rules
* AuthorizationContext = Layer 5 resolved authorization closure



## 4. Index Eligibility States

The system defines three indexing states:

```id="8m2v6x"
INDEXABLE
PARTIALLY_INDEXABLE
NON_INDEXABLE
```

These states are independent from IVL, but derived from it.



## 5. State Definitions

### 5.1 INDEXABLE

Definition:

> The element may be fully included in public indexing structures.

Properties:

* Fully discoverable via index queries
* No structural masking required
* Metadata may be emitted in full form (subject to downstream rules)

Constraints:

* Must still comply with IVL visibility (cannot override DENIED)



### 5.2 PARTIALLY_INDEXABLE

Definition:

> The element may be included in indexing structures in a reduced or abstracted form.

Properties:

* Field-level suppression required
* Identifier abstraction allowed
* Structural placeholder permitted without full resolution

Examples of transformation:

* hashed identifiers
* redacted metadata fields
* abstract node references

Constraint:

> Must preserve graph integrity while reducing semantic exposure.



### 5.3 NON_INDEXABLE

Definition:

> The element must not appear in any externally discoverable index.

Properties:

* No inclusion in search structures
* No reference nodes allowed
* No metadata leakage permitted

Constraint:

* Terminal exclusion from all indexing layers



## 6. Mapping from Visibility Levels

Index eligibility is derived from IVL using deterministic mapping rules:

| IVL State   | Index State         |
| -- | - |
| VISIBLE     | INDEXABLE           |
| CONDITIONAL | PARTIALLY_INDEXABLE |
| RESTRICTED  | PARTIALLY_INDEXABLE |
| DENIED      | NON_INDEXABLE       |



## 7. Evaluation Order Integration

Public Indexing Rules are evaluated **after IVL assignment** and **before API emission**.

### Pipeline Placement:

```id="z8k2mp"
Stage 4 → IVL Assignment  
Stage 4.5 → Public Indexing Evaluation (this spec)  
Stage 5 → Cross-Domain Resolution  
Stage 6 → EDS Assembly / API Output
```



## 8. Deterministic Index Evaluation Function

Each element is evaluated using:

```id="2n9q7v"
IndexState(e) = f(IVL(e), Schema(e), Authorization(e))
```

Where:

* IVL(e) is the visibility classification
* Schema(e) defines structural constraints
* Authorization(e) defines effective access bounds



## 9. Structural Constraints

### 9.1 Index Integrity Requirement

All index structures MUST remain:

* graph-consistent
* referentially stable
* deterministically reproducible

### 9.2 No Orphaned Exposure Rule

No indexed element may reference:

* DENIED IVL elements
* NON_INDEXABLE elements
* unresolved authorization nodes



## 10. Partial Indexing Rules

When PARTIALLY_INDEXABLE is assigned:

The system MUST apply one or more of the following transformations:

* Identifier hashing (schema-defined)
* Field redaction
* Structural anonymization
* Reference substitution with proxy nodes

Constraint:

> Transformation MUST preserve graph topology without exposing underlying sensitive values.



## 11. Denial Propagation Rule

If IVL = DENIED:

Then:

* IndexState MUST = NON_INDEXABLE
* No structural representation is permitted
* No metadata may be emitted

This is a **hard propagation rule** and cannot be overridden.



## 12. Consistency Requirements

Public indexing MUST satisfy:

### 12.1 Determinism

Same inputs → identical index structures

### 12.2 Referential Stability

Index node identifiers MUST remain stable across evaluations

### 12.3 Schema Lock Dependency

Index structure MUST follow schema-locked definitions from Stage 2 (05-02 pipeline)



## 13. Failure Model

### 13.1 Schema Conflict

If schema mismatch occurs:

* IndexState MUST default to NON_INDEXABLE

### 13.2 IVL Unresolved

If IVL is missing or invalid:

* IndexState MUST default to NON_INDEXABLE

### 13.3 Authorization Failure

If authorization context is incomplete:

* IndexState MUST default to NON_INDEXABLE

Failure behavior is strictly **fail-closed**.



## 14. Security Constraints

Public indexing introduces a **controlled discovery surface**, therefore:

* No elevation of visibility through indexing is permitted
* Index structures MUST NOT expose restricted IVL content indirectly
* Graph traversal MUST respect IVL and authorization boundaries
* No inference leakage paths may be introduced via indexing metadata

Security principle:

> Indexing may reduce discoverability, never expand visibility.



## 15. System Invariants

The following invariants MUST always hold:

* DENIED IVL ⇒ NON_INDEXABLE (absolute)
* INDEXABLE elements MUST be VISIBLE or equivalent in IVL
* PARTIALLY_INDEXABLE elements MUST NOT expose raw identity data
* Index structures MUST remain schema-consistent
* No indexing state may override IVL state
