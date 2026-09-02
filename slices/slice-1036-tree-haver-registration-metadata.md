# Slice 1036: TreeHaver Registration Metadata

## Status and scope

This slice makes the TreeHaver half of Slice 1026's capability negotiation
concrete. It defines the metadata registered by parser packages, the parser
requirements registered by merge providers, and the selectors accepted by the
existing `parser_for` entry point.

It does not add a second parse API. `TreeHaver.parser_for` remains the only
selection entry point, and every selected parser continues to expose the shared
TreeHaver parser/tree/node contract.

## Separate identities

Selection must not collapse these identities:

- **backend descriptor:** an execution adapter such as `mri`, `rust`, `java`,
  `tslp`, `prism`, `psych`, `rbs`, `citrus`, or `parslet`;
- **backend family:** a compatibility class such as `tree-sitter`, `native`,
  `peg`, or `schema`;
- **language registration:** one backend or compatible backend family serving a
  language/dialect with a parser or grammar and declared capabilities;
- **merge provider:** merge behavior selected by `ast-merge`, not a parser;
- **normalized contract:** a versioned parse/tree envelope, not a backend type.

The released Ruby `backend_type` keyword currently carries more than one of
these meanings. It remains a compatibility selector while callers migrate to
the explicit fields below; it is not part of the portable identity model.

## Backend descriptor

Each TreeHaver backend descriptor contains:

- schema, stable `id`, and `family`;
- host runtime and adapter identity;
- package name and version;
- availability mode and stable probe identity;
- normalized contract versions the adapter can expose;
- baseline adapter capabilities;
- integer priority, default zero;
- metadata and versioned extensions.

Registration of a duplicate backend ID fails unless an explicit replacement
operation creates a new registry generation. Availability probes are callable
registry state referenced by stable IDs; callables are not serialized.

## Language registration

Each language registration contains:

- schema and stable `registration_id`;
- language and supported dialects;
- backend binding: explicit backend IDs and/or one backend family, plus the
  runtime-local adapter key;
- parser/grammar identity and version where known;
- normalized contract versions;
- capability descriptors;
- loadability mode and stable language probe identity;
- integer priority, default zero;
- language-profile memberships;
- metadata and versioned extensions.

A capability descriptor contains a stable capability ID, support level
`unavailable`, `partial`, or `full`, and evidence references. Required
capabilities are hard filters at a declared minimum level. The initial common
vocabulary includes normalized nodes, exact byte spans, point spans, exact
source fragments, comments, attachment hints, error nodes, partial trees,
incremental parsing, and native extensions.

Tree-sitter grammar-library registrations may bind to the `tree-sitter` family
instead of one runtime ID because MRI, Rust, FFI, and Java adapters can consume
the same grammar asset. A TSLP registration binds to `tslp` because TSLP owns
its on-demand grammar loading interface. Native parser registrations bind to
their concrete backend ID.

## Merge-provider parser requirements

Every merge-provider descriptor contains one parser-requirements record rather
than using its flat advertised `backends` list as selection policy. The record
contains:

- required language and allowed dialects;
- allowed and denied backend IDs and families;
- required normalized contracts;
- required capabilities with minimum support levels;
- ordered backend preferences and optional language-profile ID;
- whether native extensions are required or merely retained when available;
- metadata and versioned extensions.

Allowed sets constrain eligibility. Preferences rank candidates that already
satisfy every constraint. Neither package installation nor provider load order
is a preference.

Examples:

- `ruby-merge` allows the `tree-sitter` family, so MRI, Rust, FFI, Java, and
  TSLP-style registrations can compete when they satisfy the common contract.
  It does not implicitly allow Prism.
- `prism-merge` requires backend ID `prism` and native extensions.
- `rbs-merge` allows native RBS and `tree-sitter`, with its default order
  supplied by an RBS language profile or an explicit request/environment
  override, not provider-side conditionals.

## parser_for selectors

The target Ruby surface remains one method:

```ruby
TreeHaver.parser_for(
  language,
  backend_id: nil,
  backend_family: nil,
  dialect: nil,
  required_contracts: [],
  required_capabilities: {},
  preferred: [],
  language_profile: nil
)
```

An explicit backend ID, including one produced by `TreeHaver.with_backend` or
the documented environment configuration, is a hard constraint. Backend family
and requirements are filters. `preferred` and language-profile order are only
ranking inputs. Calls without an eligible loadable registration fail closed
with candidate diagnostics.

The compatibility keywords `contract` and `backend_type` may be translated
into explicit requirements during migration. They must not remain an alternate
selection algorithm.

## Snapshot and selection result

Backend and language registries share a monotonically increasing generation and
stable snapshot digest. Register, replace, unregister, scoped override, and
reset invalidate selection/loadability caches. A request retains its immutable
snapshot for the operation.

Selection returns or attaches a report containing every candidate's backend and
registration IDs, availability, loadability, compatibility, capability levels,
rank components, rejection reasons, and selected state. The report identifies
the registry generation/digest and is carried into the normalized parse result
and merge-provider result.

## Cold-load rule

`loadable` is evaluated through the language registration's intended interface.
For TSLP this means asking TSLP to load or parse the requested grammar on demand.
A cold TreeHaver or TSLP cache is not evidence that the grammar is unavailable.

## Released Ruby gap

At the v7.1.7 golden-master revision:

- `BackendReference` stores only ID and family;
- language registrations are mutable, unvalidated backend-config hashes;
- registry generations, immutable snapshots, and digests are absent;
- `parser_for` has hard-coded native/parser ordering and overloads
  `backend_type`/`contract` selection;
- capability requirements are not applied during parser selection;
- `ast-merge` provider capabilities expose a flat `backends` list but no
  validated parser-requirements record;
- selection does not return the complete candidate trace required by Slice
  1026.

These are implementation gaps, not behavior to reproduce in Rust or Alef.

## Conformance

Conformance proves explicit selection, family selection, capability filtering,
stable preference ordering, duplicate rejection, scoped reset, cold TSLP load,
generic Ruby isolation from Prism, RBS profile preference, candidate tracing,
and fail-closed behavior. Merge packages must not recreate any of those rules.
