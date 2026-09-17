# Merge-provider registry foundation

This contract implements the registration/snapshot portion of
[Slice 1026](slices/slice-1026-capability-negotiation.md). It does not replace that
slice's two-stage negotiation algorithm. `ast-merge` owns merge-behavior
registration; TreeHaver continues to own parser registration and parse entry.
Provider and parser IDs are not interchangeable.

## Declarations

A merge-provider descriptor carries `provider_id`, `family`, explicit `workflow`
or `backend` role, operations, dialects, profiles, capabilities, source-preservation
guarantees, priority (default zero), parser requirements, allowed delegation
targets, runtime, package/version, metadata and native extensions. Operations are
the common `analyze`, `diff2`, `merge2`, `merge3` names; at least one is required.

Parser requirements declare allowed/forbidden backend IDs and families, languages,
dialects, normalized contracts, capabilities and parser profiles. Empty requirement
sets add no constraints. They never authorize calling a parser outside TreeHaver.
Their interpretation during negotiation remains subject to Slice 1026.

Set-valued declarations are sorted before storage. Duplicate values, empty or
whitespace/control-containing names, self-delegation, and contradictory allow/deny
constraints are rejected. Names are limited to 256 UTF-8 bytes, sets to 256 members,
encoded descriptors to 65,536 bytes and registrations to 1,024 per registry.
Metadata and native extensions are preserved, not interpreted as authority.
Delegation targets may be registered later; declaration alone cannot authorize
execution of a missing or incompatible target.

## Lifecycle and observation

Registration rejects duplicate IDs. Replacement, removal and explicit clear require
the observed generation and fail atomically on a stale generation. Replacement of
an unknown ID fails. Every successful mutation advances the generation without
wrapping. No mutation implicitly replaces or clears another provider.

Snapshots retain cached declarations and executor handles. Replacing/removing a
provider affects later snapshots only. Provider destruction happens outside registry
locks, including replacement and clear. Snapshot destruction releases the retired
executor when its last handle is gone; this does not assert host-runtime shutdown
or callback thread-affinity safety.

The inventory schema is `structuredmerge.merge-provider-inventory/v1`, containing
`generation`, `descriptor_digest` and `providers` in stable provider-ID order.
The digest is SHA-256 of compact serde JSON for the normalized descriptor array.
It identifies declarations, not executable code. Replacing a handle with identical
declarations changes the generation but not the digest. Generations are meaningful
only within their originating registry instance. Caller changes to an owned
inventory cannot change the registry or its snapshots.

Inventory and exact-ID handle lookup do not probe, select, dispatch, negotiate
parser requirements, or grant default approval. A backend's presence or priority
cannot yet change family selection because this foundation performs no selection.

## Remaining gates

The kernel's source-free selection layer now filters merge declarations and
negotiates their parser requirements through TreeHaver before ranking eligible
providers. Explicit IDs are hard constraints; family-only queries admit only
workflow-role providers. Ranking is explicit match, descending priority, stable
ID. Both immutable snapshots and all attempted parser reports remain associated
with the decision. TreeHaver constraints are conjunctive with existing application
restrictions and apply equally to parser observations and dispatch.

Versioned parser-profile requirements remain unsupported and fail closed before
probing. The existing language preference lists are not a substitute for such a
profile catalog. This source-free engine is not the complete portable capability
envelope, a host availability check, delegation, or actual workflow execution.

The Rust typed facade now connects explicit `WorkflowHost` batch execution to
this registry and selection layer; see `TYPED_WORKFLOW_HOST_CONTRACT.md`.
Generated bindings and unified Rust-executor registration remain open. It must complete
parser-profile negotiation, allowed delegation, request/result validation,
explicit execution ownership, cancellation and binding-runtime lifecycle rules.
The existing explicitly selected kernel profiles remain unchanged meanwhile.

Neither this registry nor a successful future host callback proves that merge
semantics migrated to Rust. Host-owned workflows must remain identified as such.
No prototype dependency, publication requirement or default-provider promotion is
introduced by this contract.
