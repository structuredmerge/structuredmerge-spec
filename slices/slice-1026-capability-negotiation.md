# Slice 1026: Capability Negotiation

## Status and scope

This slice defines deterministic selection across the two registries used by
StructuredMerge:

1. `ast-merge` selects a merge provider; and
2. TreeHaver selects a parser backend satisfying that provider's requirements.

The contract identifiers are:

- `structuredmerge.capability-request/v1`;
- `structuredmerge.capability-result/v1`.

This slice supersedes Slice 25's description of the backend registry as merely
descriptive. It preserves Slice 132's backend ownership boundary and Slice
266's rule that provider identity is execution context, not portable grammar
identity.

## Non-interchangeable identities

A merge provider and parser backend are different things.

A merge-provider registration identifies merge behavior: family, dialects,
operations, profiles, source-preservation guarantees, workflow/backend role,
and parser requirements. Examples include `ruby.rbs`, `ruby.ruby`, and
`ruby.ruby.prism`.

A TreeHaver backend registration identifies parsing behavior: backend ID and
family, target languages/dialects, normalized contract, parser capabilities,
availability probe, and package/parser identity. Examples include `tslp`,
`mri`, `rust`, `java`, `prism`, `psych`, and `rbs`.

Names may resemble one another but are never substituted across layers. A
request for merge provider `ruby.ruby.prism` may constrain TreeHaver to backend
`prism`; setting merge provider ID to `prism` is not equivalent.

## Merge-provider registration

Every registration contains:

- stable `provider_id` and `family`;
- role: `workflow` or `backend`;
- supported operations, dialects, profiles, and merge capabilities;
- source-preservation guarantees;
- integer priority, default zero;
- parser requirements;
- optional allowed delegation targets;
- package identity and version;
- metadata and extensions.

Parser requirements are constraints, not direct parser calls. They may declare
allowed or forbidden TreeHaver backend IDs/families, required normalized
contract versions, capabilities, languages, dialects, and parser profiles.

A workflow provider is the family default candidate. Merely registering a
backend provider MUST NOT replace or outrank a workflow provider for a
family-only request. Backend providers become candidates only through an
explicit provider ID, explicit backend-provider selector, or an allowed
delegation decision made by the workflow provider.

This prevents installing `prism-merge` from changing `ruby-merge` into a Prism
implementation. It also permits `rbs-merge` to remain one workflow provider
while TreeHaver selects either native RBS or a compatible Tree-sitter backend.

## TreeHaver backend registration

Every registration contains:

- stable backend `id` and backend `family`;
- host runtime and package identity/version;
- supported languages and dialects;
- normalized parse contract versions;
- parser capabilities;
- availability mode and probe identity;
- integer priority, default zero;
- metadata and extensions.

Backend family examples are `tree-sitter`, `native`, `peg`, and `schema`.
Multiple runtime bindings for Tree-sitter share the `tree-sitter` family while
retaining distinct IDs such as `mri`, `rust`, `ffi`, `java`, and `tslp`.

Capabilities include exact source spans, point spans, normalized nodes,
comments, attachment hints, error nodes, partial trees, incremental parsing,
native extensions, and exact source-fragment extraction. Boolean capability
presence and richer support levels are both explicit; selection never infers a
capability from a class name.

## Availability and cold start

Registration, availability, loadability, compatibility, and selection are
separate states.

- `registered`: metadata exists;
- `available`: required runtime/package can be reached;
- `loadable`: the requested language grammar/parser can be loaded through the
  backend's intended interface;
- `compatible`: all request and merge-provider constraints pass;
- `selected`: this candidate won deterministic ranking.

An availability probe MUST use the backend's intended lazy-loading interface.
It MUST NOT assume a language is unavailable because a grammar cache is cold.
For TSLP, grammar discovery/loading occurs on demand through TSLP; preloaded
cache membership is not capability evidence.

Probe failures become candidate diagnostics. They do not permit a parser call
outside TreeHaver. A request with no compatible loadable candidate fails
closed.

## Capability request

A request contains:

- `schema` and `request_id`;
- operation, family, dialect, and optional merge profile;
- `provider_selection` from Slice 1025;
- `parser_selection` from Slice 1025;
- required merge, parse, and preservation capabilities;
- registry snapshot requirements;
- metadata and extensions.

An explicit provider or backend ID is a hard constraint. Ordered parser
preference is a ranking input, not permission to ignore capability failures.
Environment variables may construct a request but do not alter the portable
ranking rules.

## Deterministic algorithm

Selection proceeds in two stages.

### Merge provider

1. Snapshot the provider registry.
2. Filter by explicit provider ID when present; otherwise filter to workflow
   role.
3. Filter by family, operation, dialect, profile, and required capabilities.
4. Reject registrations whose parser requirements cannot be negotiated.
5. Rank by explicit match, descending priority, then stable provider ID.
6. Select one or fail with candidate diagnostics.

For an explicit provider ID, no other provider may be selected. Duplicate IDs
are registration errors unless an explicit replace operation creates a new
registry generation.

### Parser backend

1. Snapshot TreeHaver backend and language registrations.
2. Filter by explicit backend ID when present.
3. Filter by language, dialect, normalized contract, provider requirements,
   and requested parser capabilities.
4. Probe availability and language loadability through each eligible backend.
5. Rank an explicit match first, then request preference order, language-profile
   preference order, descending priority, and stable backend ID.
6. Select one or fail closed with candidate diagnostics.

Registration or require/load order MUST NOT affect either stage. Legacy
hard-coded backend-type order is an implementation compatibility mechanism,
not portable authority, and must migrate to explicit language-profile
preference metadata.

## Result and decision trace

A capability result contains:

- `schema`, `request_id`, and `ok`;
- provider and TreeHaver registry generation/digest;
- ordered provider candidates;
- selected merge provider and delegation policy;
- ordered parser candidates;
- selected TreeHaver backend and selection mode;
- satisfied and unsatisfied capabilities;
- diagnostics, extensions, and metadata.

Every candidate records eligibility, availability, loadability, compatibility,
rank components, rejection reasons, and whether it was selected. A result may
redact sensitive paths but not identities, capabilities, decisions, or
rejection categories.

The selected parser report is passed into Slice 1025's `profile.parser` and
Slice 1024's parse selection report. The merge result therefore proves both
which behavior provider ran and which parser backend supplied its syntax facts.

## Registry lifecycle

Registries expose monotonically increasing generations and stable snapshot
digests. Register, replace, unregister, and clear/reset operations create a new
generation and invalidate selection and availability caches derived from an
older generation.

Tests use scoped registration/reset tooling and MUST NOT repair a dirty registry
with private mutation or duplicate selection logic. Concurrent requests retain
the immutable registry snapshot they began with; a registration change affects
only later requests.

Availability cache identity includes registry generation, backend/package
identity, language/dialect, and probe configuration. A cache entry for one
language or TSLP grammar cannot prove another language loadable.

## Delegation

A workflow provider may delegate only to a target declared in its registration
and compatible with the request. The result records the complete ordered
delegation chain and the parser requirements introduced at each step.

Delegation is not fallback. If a selected target fails and no alternative was
explicitly allowed by policy, the operation fails. A backend provider never
becomes the family default because it was loaded first or has a high parser
priority.

## Known Ruby migration gap

Ruby `ast-merge` provider selection already uses workflow role, priority, and
stable provider ID for deterministic family selection. TreeHaver supports
explicit backend context, contract filtering, and caller preference, but still
contains legacy backend-type ordering before its generic registered-backend
path. That ordering must be represented as language-profile preference and
removed as hidden global policy in a later Ruby change.

The gap is recorded rather than copied into Rust or Alef bindings.

## Conformance

Conformance MUST prove:

1. provider and parser identities cannot cross selection layers;
2. family-only requests consider workflow providers only;
3. explicit provider/backend requests never substitute another candidate;
4. required capabilities and parser contracts are hard filters;
5. priority ties resolve by stable ID, never registration order;
6. a generic Ruby provider is not hijacked by registered Prism support;
7. a multi-backend RBS provider follows explicit/profile preference;
8. cold TSLP grammar loading uses its intended interface and can succeed with
   an empty grammar cache;
9. no compatible loadable backend fails closed;
10. selection reports every candidate and rejection reason;
11. registry mutation invalidates older caches and changes generation;
12. scoped test reset restores the prior snapshot;
13. delegation remains explicit, allowed, and fully reported.

## Non-goals

- prescribing one default backend for every installation;
- making native and Tree-sitter ASTs equivalent beyond normalized contracts;
- loading every TSLP grammar at startup;
- treating installed packages as automatically advertised capabilities;
- permitting parser fallback outside TreeHaver.
