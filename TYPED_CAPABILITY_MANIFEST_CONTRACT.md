# Typed kernel capability manifest

`structuredmerge.typed-capability-manifest/v1` is a source-free observation
contract for explicit kernel operation profiles. It complements
[Slice 1026](slices/slice-1026-capability-negotiation.md); it does not implement
or replace that slice's general workflow-provider negotiation, delegation,
family-default selection, or `structuredmerge.capability-result/v1` envelope.

The typed facade exposes `capability_manifest(queries, limits)` and a controlled
variant accepting an operation cancellation handle. Each query contains a
`profile_id`, operation, optional dialect, and TreeHaver parser selection.
Queries contain no source bytes and MUST NOT cause parsing or merge execution.

## Declarations and observations

The manifest includes its schema, kernel version, static operation profile
catalog, parser registry inventory, and observations in request order.
Declarations retain provider identity, operation/dialect scope, syntax limits,
required parse contract/native extension, experimental status, and explicit
default approval. Listing declarations MUST NOT probe providers or replace an
unknown static availability field with a request-specific conclusion.

Each observation retains the original query and separates:

- `operation_declared` and `dialect_declared`: the profile declares the requested
  operation/dialect, subject to its documented syntax and policy restrictions;
- `parser_request` and `parser_report`: the exact derived source-free selection
  request and the TreeHaver selection evidence, or absent when unprobed;
- `parser_eligible`: unknown when unprobed, otherwise whether a backend was
  selected under that request; and
- `approved_as_default`: the profile's explicit authority decision, independent
  of successful registration, probing, or selection.

Unsupported operation/dialect combinations MUST NOT probe. Unknown profile IDs
reject the entire batch before callbacks. An empty query list inventories only.
No eligible parser yields an observation with `parser_eligible = false`, not
fallback or an operation-support claim. Candidate rejections, availability,
loadability and probe faults remain visible in the parser report. In particular,
false eligibility MUST NOT be interpreted unconditionally as "not installed."

Derived parser language/options MUST match common-operation dispatch. JSONC and
JSON5 use parser language `json5`; TSX uses `tsx`. Native owner profiles require
the native-extension channel. JSON analysis additionally requires comment and
diagnostic channels. Successful eligibility does not establish that eventual
parse output supplies valid native facts, required extension payloads, supported
syntax, or source-preservation evidence.

## Snapshot and execution controls

One immutable registry snapshot supplies inventory and every query observation.
Every parser report's generation/digest MUST match that inventory, including
when a callback unregisters or replaces a provider. The result is an observation,
not a lease or promise that a later operation uses the same registration.

`max_batch_items` bounds query count. Byte/node limits do not apply without
source input. Cancellation/deadlines apply before work, around callbacks, and
before returning, including empty inventories. Callbacks are cooperative; a
deadline rejects late results rather than forcibly terminating native code.

## Conformance and limits

Shared `polyglot/typed-core/capability_*.json` fixtures exercise both generated
Ruby and Python targets. They cover all eight declared profiles with an explicit
missing backend, undeclared operations, undeclared dialects, parser-language
mapping, unknown-versus-false eligibility, and inventory without source input.
Installed boundary tests separately exercise successful/faulted native probes,
invalid batch preflight, limits, cancellation and reentrant snapshot retention.

These are explicit-profile observations, not complete Slice 1026 conformance,
Ruby golden-master parity, host-workflow migration, supported-platform approval,
source-specific merge success, publication approval, or default promotion.
