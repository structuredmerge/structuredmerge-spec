# Slice 1028: Stable Diagnostic and Conflict Serialization

## Status and scope

This slice tightens the diagnostic and conflict records introduced by Slices
02, 1024, and 1025. It defines stable machine-readable reasons, deterministic
ordering and causality, exact conflict alternatives, localization, and
resolution. It does not change provider operations or define family merge
semantics.

The contract identifiers are:

- `structuredmerge.diagnostic/v1`;
- `structuredmerge.conflict/v1`.

These records are embedded in Slice 1025 provider results and may also appear
in parse, analysis, registry, renderer, verifier, Git adapter, benchmark, and
batch envelopes. Unknown compatible fields and namespaced extensions are
preserved when records are forwarded.

## Stable values and compatibility

Machine consumers branch on schema, category, code, severity, blocking state,
source role, conflict status, and resolution strategy. They MUST NOT branch on
human messages, exception class names, stack traces, rendered conflict markers,
or provider object identities.

Portable enum values use lowercase snake case. Stable codes use lowercase
dot-separated snake-case segments, for example `parse.unexpected_eof` and
`merge.edit_edit`. Historical hyphenated values are accepted only by migration
adapters and are serialized in canonical form before crossing a portable
boundary.

The Slice 02 category values remain valid. `destination_parse_error` is retained
for compatibility; new producers SHOULD use `parse_error` with an exact source
role such as `current`. Provider-native error codes move to `origin.native_code`
and do not replace the portable `code`.

## Diagnostic envelope

Every diagnostic contains:

- `schema`, equal to `structuredmerge.diagnostic/v1`;
- result-local deterministic `id`;
- zero-based `sequence` within its containing diagnostic array;
- `severity`: `info`, `warning`, or `error`;
- portable `category` and stable namespaced `code`;
- human `message`;
- `blocking`;
- optional `operation` and `request_id`;
- ordered `source_refs`;
- optional subject references;
- ordered `cause_ids` and `related_ids`;
- `origin`, `data`, `extensions`, and `metadata`.

### Core categories

The v1 core category registry is:

- `parse_error` and compatibility-only `destination_parse_error`;
- `invalid_request` and `configuration_error`;
- `selection_error` and `backend_unavailable`;
- `unsupported_feature` and `ambiguity`;
- `analysis_error` and `merge_conflict`;
- `render_error`, `preservation_error`, and `verification_error`;
- `fallback_applied` and `assumed_default`;
- `cancelled`, `deadline_exceeded`, and `resource_limit`;
- `replay_rejected` and `internal_error`.

Categories describe the broad portable failure domain. Codes carry the stable
reason within that domain. Family- and backend-specific detail belongs in a
namespaced code, structured `data`, or an extension, not in a new ad hoc core
category.

### Source and subject references

A source reference contains source ID, semantic role, and optional Slice 722
span, node ID, owner reference, or region ID. The first item is primary for
display only; all source references remain semantically relevant. A merge
conflict diagnostic may therefore reference base, ours, and theirs without
pretending one revision caused the conflict.

Subject references may identify an owner, structural path, change, conflict,
render fragment, preservation claim, backend candidate, or operation. Every
reference resolves within the containing result or an explicitly identified
embedded contract.

### Origin and native errors

`origin.layer` is one of `transport`, `registry`, `parser`, `analysis`,
`provider`, `renderer`, `verifier`, `adapter`, or `runner`. Origin may identify
the provider, backend, package, package version, and native code. Native code is
opaque evidence. A consumer cannot infer portable semantics from it.

Exceptions and stack traces may appear only in redacted diagnostic data under
an explicit debug policy. They are never stable codes and MUST NOT expose
source content, credentials, environment secrets, or absolute paths by
default.

## Ordering, identity, and causality

Diagnostic array order is deterministic for fixed inputs and configuration.
Sequences are contiguous from zero and agree with array order. IDs are derived
from stable result-local facts and occurrence order; timestamps, random values,
thread scheduling, hash iteration, parser pointers, and exception object IDs
are forbidden inputs.

`cause_ids` form an acyclic graph. A cause must precede the diagnostic that
references it. `related_ids` may point in either direction but do not imply
causation. Duplicate IDs, missing references, forward causes, and causal cycles
are invalid.

Parallel execution may discover diagnostics in any order internally. The
provider sorts them into semantic operation order before serialization: request
and selection, parse by request role order, analysis, merge classification,
rendering, preservation, verification, adapter, then runner. Stable source
range and code break ties.

## Blocking and operation outcome

Severity and blocking are separate. A recovered parser error can be nonblocking
only when the selected backend advertises recovery and the provider proves the
requested operation remains valid. A warning may block when policy elevates a
safety condition, but the diagnostic data must identify that policy.

When an operation has `ok: false` and no unresolved conflict, at least one
blocking diagnostic is required. An unresolved conflict itself makes a merge
operation unsuccessful; its associated diagnostic SHOULD be blocking but the
conflict envelope, not the diagnostic text, is authoritative. No diagnostic
may turn failed required preservation into success.

## Conflict envelope

Every conflict contains:

- `schema`, equal to `structuredmerge.conflict/v1`;
- result-local deterministic `id`;
- `operation`, portable `category`, stable namespaced `code`, and optional
  human `message`;
- a subject or explicit whole-document subject;
- ordered semantic `roles`;
- one ordered alternative per role;
- classification evidence;
- localization and resolution records;
- diagnostic, change, decision, and render references;
- `extensions` and `metadata`.

The v1 conflict categories are `content`, `delete_modify`, `add_add`, `move`,
`rename`, `order`, `identity`, `ownership`, `syntax`, `binary_overlap`,
`archive_entry`, and `provider_specific`. Codes distinguish details such as
`merge.edit_edit`, `merge.delete_edit`, or a namespaced provider reason.

### Subject and alternatives

A subject identifies at least one structural path, owner reference, node
reference, archive entry, binary region, or `whole_document: true`. A parser
that cannot identify a precise owner reports coarse scope honestly rather than
inventing a path.

For `merge3`, roles are `base`, `ours`, and `theirs` in that order. For
directional `merge2`, roles are `incoming` and `current`. Alternatives preserve
that role order. Each alternative states `present`, `absent`, `invalid`, or
`opaque`, identifies its source when present, lists zero or more exact regions
and digests, and references the changes that produced it. Absent alternatives
have no fabricated source range.

Inline content is optional. Large or sensitive alternatives use the same
content-addressed local reference model as Slice 1024. Source IDs, ranges, and
digests remain authoritative even when content is omitted from transport.

### Classification and localization

Classification evidence records the change, match, owner, or policy decisions
that established incompatibility. A `merge3` conflict must prove base
participation; a conflict inferred from only ours and theirs is invalid.

Localization status is one of:

- `exact`: every present alternative has verified exact byte regions;
- `owner`: the owning structural region is known but the conflicting token is
  not isolated;
- `coarse`: a containing region is known;
- `whole_document`: only document-level conflict is supported;
- `unavailable`: no safe location can be reported.

The record distinguishes per-source regions from optional rendered-output
regions. Benchmark expected/observed conflict regions reference this conflict
ID and localization evidence. They do not redefine the conflict.

### Resolution

Resolution status is `unresolved` or `resolved`. An unresolved resolution has
strategy `none`, no selected role, and no resolution decision. A resolved
conflict uses `select_role`, `combine`, `policy`, or `custom`; it identifies
selected roles, authorizing decision, resolver, and reason.

Resolved conflicts may remain in a successful result as audit evidence.
Unresolved conflicts make `ok: true` invalid. A provider MUST NOT silently
remove a conflict record after applying an explicit conflict policy.

## Rendering and preservation

Conflict markers are Slice 1019 synthesized presentation fragments linked by
conflict ID. Marker presence, labels, and byte ranges may be reported in render
and Slice 1027 preservation evidence, but marker scanning cannot create or
classify a conflict envelope.

Each source alternative and localized output fragment retains exact byte
evidence. Unknown syntax inside an alternative remains source, not diagnostic
metadata. A coarse or whole-document conflict does not authorize unrelated
whitespace churn.

## Serialization and forwarding

Arrays whose order is defined here retain order. JSON object key order is not
semantic. UTF-8 string transport does not replace source-byte descriptors.
Unknown compatible fields, diagnostic data, native origin data, and namespaced
extensions survive forwarding unchanged.

Batch results retain independent ID scopes. Cross-result references include the
request/result ID; a bare result-local diagnostic or conflict ID cannot point
into another batch item.

## Conformance

The canonical fixture MUST prove:

1. diagnostic categories and codes use canonical portable forms;
2. sequences are contiguous and causal diagnostics follow their causes;
3. source roles and spans resolve to exact source descriptors;
4. native codes remain separate from portable codes;
5. an unresolved merge3 conflict contains base/ours/theirs alternatives and
   proves base participation;
6. exact localization verifies every present alternative range and digest;
7. one conflict may reference multiple diagnostics without relying on message
   text;
8. conflict records remain authoritative without marker output;
9. resolved conflicts identify strategy and authorization;
10. unstable IDs, causal cycles, role loss, marker-only conflicts, false exact
    localization, and successful unresolved conflicts are rejected.

## Non-goals

- defining family conflict classification algorithms;
- making messages or native exceptions portable APIs;
- requiring exact localization from binary or low-fidelity providers;
- requiring rendered conflict markers;
- replacing Slice 1027 preservation evidence;
- introducing a second operation result envelope.
