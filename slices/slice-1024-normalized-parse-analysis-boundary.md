# Slice 1024: Normalized Parse and Analysis Boundary

## Status and scope

This slice defines the first versioned transport boundary extracted from the
canonical Ruby `tree_haver` and `ast-merge` behavior. It standardizes the data
needed by a merge runtime without requiring every parser to expose the same
native AST.

The contract identifiers are:

- `structuredmerge.parse-request/v1`;
- `structuredmerge.parse-result/v1`;
- `structuredmerge.analysis-result/v1`.

This slice composes rather than replaces existing contracts:

- Slice 722 defines half-open byte locations and byte-oriented points;
- Slice 955 defines comment, trivia, attachment, and layout-gap behavior;
- Slice 1018 defines `analyze`, `diff2`, `merge2`, and `merge3` provider
  envelopes;
- Slice 1019 defines source render plans and output provenance.

Unknown major versions MUST be rejected. A compatible reader MUST preserve
unknown fields and namespaced extensions when forwarding a record.

## Authority and boundary

Ruby behavior is the golden master for this contract. The normalized surface
is extracted from behavior exercised by Ruby fixtures and tests; it is not a
union of the current Ruby, Go, Rust, and TypeScript implementations.

TreeHaver remains the only parser-selection and parse-entry boundary. A caller
MUST NOT invoke a parser directly and then manufacture a conforming envelope.
If TreeHaver cannot select a backend satisfying the request, parsing fails
closed with a structured diagnostic. Selection among registered TreeHaver
backends is valid, but it is explicit in the selection report and never hidden
as a parser fallback outside TreeHaver.

The transport is a projection, not a replacement for a native AST. A provider
MAY retain a native tree in-process and expose versioned native extensions.
Consumers MUST NOT require a provider to flatten information-rich native nodes
into a lossy universal node shape.

## Common rules

Identifiers are non-empty UTF-8 strings. Enum values are lowercase
snake-case strings. Arrays whose order reflects source order or provider
preference retain that order; capability sets are sorted and unique.

All source ranges are half-open byte ranges. Rows and columns are zero-based,
and columns count bytes from the beginning of the row. A span contains:

```json
{
  "range": {"start_byte": 0, "end_byte": 12},
  "start_point": {"row": 0, "column": 0},
  "end_point": {"row": 1, "column": 0}
}
```

The source bytes, not decoded characters or parser-native offsets, are
authoritative. Every non-virtual normalized node span MUST fit within its
source. Child spans MUST fit within their parent unless a namespaced extension
declares and explains a non-nesting native relationship.

SHA-256 values are lowercase hexadecimal digests over exact bytes. Source
records state byte length, encoding label, BOM presence, line-ending profile,
and final-newline state. These fields are preservation evidence, not hints for
normalization.

## Parse request

A parse request contains:

- `schema`, equal to `structuredmerge.parse-request/v1`;
- `request_id`;
- `source`, containing `source_id`, semantic `role`, exact content or a
  content-addressed local reference, byte length, SHA-256, and encoding;
- `language` and optional `dialect`;
- `selection`, containing an optional explicit backend ID, ordered backend
  preference, and required capabilities;
- `options`, including whether comments, tokens, diagnostics, and native
  extensions are requested;
- `metadata`.

The source role is semantic and MUST be retained. Typical values are `source`,
`before`, `after`, `incoming`, `current`, `base`, `ours`, and `theirs`.

A batch transport MAY carry multiple complete parse requests. Batching changes
transport overhead only; each request retains an independent identity,
selection report, diagnostics, and result.

## Parse result

A parse result contains:

- `schema`, equal to `structuredmerge.parse-result/v1`;
- `request_id` and `ok`;
- the verified `source` descriptor;
- `selection`;
- `backend` identity and capabilities;
- `root_id`;
- ordered `nodes`, `comments`, and `diagnostics`;
- `extensions` and `metadata`.

On failure, `ok` is false, `root_id` may be null, and at least one blocking
diagnostic is required. A partial tree is present only when the selected
backend advertises partial-tree support. A syntax error is not an internal
failure; diagnostics distinguish malformed source, unsupported syntax,
selection failure, provider failure, and transport failure.

### Selection report

The selection report contains:

- `mode`: `explicit` or `policy`;
- requested backend, preference, and required capabilities;
- ordered candidate records with availability and compatibility status;
- selected backend ID and selection reason, or null on failure;
- the registry generation or configuration digest used for selection.

An explicit backend request MUST NOT silently select another backend. Policy
selection MAY choose the first compatible registered backend, but its complete
decision remains observable. Process environment variables are one way to set
policy; they are not part of the portable result.

### Backend identity and capabilities

Backend identity contains:

- stable backend ID and backend family, such as `tree-sitter` or `native`;
- host runtime and package name/version;
- parser and grammar identity/version where applicable;
- target language and dialect;
- normalized contract version;
- capabilities.

Capabilities explicitly describe source spans, point spans, comments,
attachment hints, tokens, error nodes, partial trees, incremental parsing,
native extensions, and exact source-fragment extraction. Capability absence is
not inferred from missing output fields.

## Normalized node

Every normalized node contains:

- result-local `id`;
- portable `type` and provider `native_type`;
- `role`: `structural`, `token`, `trivia`, `comment`, `delimiter`,
  `separator`, `virtual`, `error`, or `opaque`;
- `named`, `missing`, and `has_error` booleans;
- `span`;
- optional `parent_id`;
- ordered child edges;
- sorted `semantic_roles` and `unsupported_features`;
- `extensions` and `metadata`.

A child edge contains `node_id`, zero-based `index`, and optional
`field_name`. Field names belong to the parent-child relationship and MUST NOT
be treated as an intrinsic property of a child node.

Node IDs are stable only within one result. Portable identity across revisions
is established later by `ast-merge` matching and MUST NOT be inferred from a
parser object ID. Exact node text is obtained by slicing source bytes with the
span; transports SHOULD NOT duplicate it. Virtual nodes use a zero-width span
and MUST explain their origin in metadata.

Native data appears only in namespaced extensions:

```json
{
  "schema": "structuredmerge.extension/ruby-prism/v1",
  "namespace": "ruby-prism",
  "capabilities": ["locals", "magic-comments"],
  "payload": {}
}
```

Shared consumers may act only on declared portable fields and extension
capabilities they understand. They preserve all other extension values
unchanged.

## Comments and parser hints

Every parser-exposed comment MUST have a normalized node with role `comment`.
The `comments` array references that node and may add style, native kind, and
an advisory attachment hint. A hint is one of `leading`, `inline`, `trailing`,
`preamble`, `postlude`, `orphan`, or `unknown`.

Parser hints are evidence, not final merge ownership. A backend that does not
advertise comment support returns an empty comment array; downstream code MUST
NOT scan source with a format-specific one-off comment detector and claim the
result came from the parser contract.

## Analysis result

`structuredmerge.analysis-result/v1` contains or content-addresses one parse
result and adds the portable merge substrate produced by family-aware analysis:

- structural owners and their parser-node references;
- logical owner identities and match keys;
- comment regions;
- layout gaps;
- attachment records;
- ownership decisions and alternatives;
- diagnostics and namespaced extensions.

This is where parser hints become reviewed family behavior. Parser-specific
packages provide syntax facts; generic language substrates own behavior shared
by that language; `ast-merge` owns behavior that generalizes across languages.

### Layout gaps

A layout gap contains:

- result-local `id`;
- `kind`: `preamble`, `interstitial`, or `postlude`;
- exact span and source digest;
- optional before/after owner references;
- `controller_side`, `before` or `after`;
- optional fallback controller;
- metadata.

Adjacent owners may reference the same gap, but exactly one retained owner
controls emission. Removing that owner transfers control only according to the
declared fallback decision. An implementation MUST NOT regenerate a retained
gap from a blank-line count when exact source bytes remain available.

### Attachments and ownership

An attachment record references one owner and its leading, inline, trailing,
or orphan comment regions plus leading/trailing layout gaps. Ownership records
contain a subject reference, selected owner, relation, decision basis,
confidence, and any unresolved alternatives.

Ownership is deterministic for a fixed parse result, family profile, and
configuration. Ambiguity is reported; it is not resolved by traversal order or
parser object identity.

## Diagnostics

Every diagnostic contains:

- `id`;
- `severity`: `info`, `warning`, or `error`;
- stable `category` and provider-native optional `code`;
- `message`;
- `source_role`;
- optional `span`, `node_id`, owner reference, and operation ID;
- `blocking`;
- metadata.

Messages are for people and are not stable matching keys. Consumers branch on
category, code, severity, and blocking state. A diagnostic span follows the
same byte semantics as a node span. Errors from one merge revision MUST retain
that revision's semantic source role.

## Preservation and render/edit handoff

Analysis does not emit a reconstructed document. It hands exact source spans,
ownership decisions, and synthesis requests to Slice 1019's render plan.

Every output region is classified as:

- `source`, with source role, source ID, exact span, and digest;
- `synthesized`, with exact bytes, producer, and reason;
- `conflict`, with explicit base/ours/theirs child regions.

An edit representation, when required by an FFI or editor host, is a projection
of the render plan. Each edit contains an input byte range, replacement bytes,
expected input digest, producer, reason, and references to the render-plan
fragments that authorized it. Edits are sorted, non-overlapping, and applied
from highest byte offset to lowest. An edit transport MUST NOT become a second
place to infer ownership, separators, indentation, or conflict localization.

Verification records output reparse status, structural equivalence,
byte-identical retained source regions, synthesized regions, diagnostics, and
requested fallback. A failed required preservation property cannot be reported
as successful output.

## Conformance

Conformance for this slice MUST prove:

1. byte ranges and points obey Slice 722 for multibyte UTF-8 source;
2. child edges are ordered, unique, and range-valid;
3. every node, comment, owner, gap, attachment, and diagnostic reference
   resolves within its result;
4. explicit backend selection never substitutes another backend;
5. policy selection records all considered candidates and its decision;
6. unavailable compatible backends fail closed without an external parser;
7. malformed input produces categorized diagnostics and only advertised
   partial trees;
8. comment hints remain distinct from family ownership decisions;
9. shared gaps have one effective controller and exact retained bytes;
10. unknown native extension payloads survive transport unchanged;
11. source-backed render regions remain byte-identical;
12. edit projections reproduce the corresponding render-plan output;
13. TSLP and native-parser snapshots satisfy the same normalized fields while
    retaining distinct extensions.

The first fixture set SHOULD include TSLP JSON plus native Prism Ruby and Psych
YAML snapshots. Later snapshots add RBS, Markdown, and TOML providers without
changing the v1 required fields.

## Non-goals

- defining one universal parser AST;
- serializing native parser objects or process-local pointers;
- selecting a parser backend outside TreeHaver;
- moving language-specific ownership policy into parser adapters;
- allowing normalized output to erase native capabilities;
- defining a new render algorithm beside Slice 1019.
