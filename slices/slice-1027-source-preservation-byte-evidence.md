# Slice 1027: Source Preservation and Byte-Region Evidence

## Status and scope

This slice defines the portable proof that a rendered merge preserved source
where policy required it. It composes the Slice 1019 render plan, Slice 1024
source and gap records, Slice 1025 operation results, and Slice 1022 benchmark
preservation policy. It does not introduce another renderer or semantic merge
protocol.

The contract identifiers are:

- `structuredmerge.preservation-policy/v1`;
- `structuredmerge.preservation-evidence/v1`.

Source preservation is a correctness condition, not a formatting score. A
semantically equivalent AST cannot excuse lost comments, changed whitespace,
normalized line endings, reordered current-owned content, or reconstructed
unknown syntax when those properties are required.

## Authority and byte model

Exact input and output bytes are authoritative. Text decoding, parser spans,
line records, and structural paths help explain evidence but cannot replace the
bytes. Ranges are half-open byte ranges. SHA-256 values are lowercase
hexadecimal digests over the exact bytes in a range.

Every source and output descriptor contains:

- stable ID and semantic role;
- exact byte length and SHA-256;
- encoding label and BOM state;
- counts of LF, CRLF, and bare CR line endings;
- final-newline state.

The complete output is partitioned into ordered, non-overlapping segments.
Segments begin at byte zero, are contiguous, and end at the declared output
byte length. No successful result contains an unexplained output byte.

## Preservation policy

A policy assigns each property one requirement:

- `required`;
- `allowed_to_change`;
- `not_applicable`.

The portable property vocabulary begins with:

- `comments`;
- `formatting`;
- `blank_line_gaps`;
- `order`;
- `lexical_style`;
- `encoding`;
- `line_endings`;
- `final_newline`;
- `unknown_fields`;
- `unknown_syntax`;
- `source_regions`.

Namespaced properties may extend this vocabulary. A policy may identify
protected source regions, owners, gaps, comments, or structural paths. A
required protected region must have a byte-exact output mapping or an explicit
authorized disposition that the property permits. Describing a gap only by
line count or blank-line count is not preservation evidence.

## Output partition

Each output segment has an ID, kind, half-open output range, byte length, and
digest. Its kind is one of:

### Source

A `source` segment additionally identifies the source ID, semantic role,
half-open source range, source digest, render-plan fragment, and merge decision
when applicable. The source and output slices MUST be byte-identical. Moving a
source fragment is allowed when semantic ordering permits it, but moving does
not permit reconstruction.

### Synthesized

A `synthesized` segment identifies its producer, reason, and authorization.
Authorization references a merge decision, render-plan request, conflict
envelope, or explicit policy rule. Its bytes and digest are reported exactly.
Family emitters may synthesize syntax unavailable in any input, but synthesized
bytes are never reported as source-preserved.

### Conflict marker

A `conflict_marker` segment is synthesized output associated with a structured
conflict ID. Marker text is presentation; the referenced conflict envelope and
its source alternatives remain authoritative.

## Region claims and dispositions

Region claims prove properties inside the output partition. Claims may overlap
partition segments and one another because a comment can also be part of a
larger retained owner fragment. Each exact claim contains source and output
ranges and digests and verifies byte equality. Claims for comments, layout
gaps, unknown fields, unknown syntax, lexical style, and untouched owners retain
their Slice 1024 analysis IDs where available.

An input region intentionally absent from output has a disposition containing:

- source ID, role, range, byte length, and digest;
- disposition such as `superseded`, `deleted`, `conflicted`, or `unselected`;
- merge decision or conflict ID;
- policy authorization and reason.

Disposition records are required for protected regions and for changed regions
used as preservation evidence. A provider need not partition every unselected
input revision, but it cannot silently omit a protected or current-owned
region.

## Property results

Every declared policy property has one result containing:

- the property and requirement;
- observed state: `preserved`, `changed`, `not_applicable`, or `unverified`;
- status: `passed`, `failed`, `not_applicable`, or `unverified`;
- evidence IDs and diagnostic IDs;
- optional namespaced metadata.

A required property passes only when the observed state is `preserved` and its
evidence verifies. `unverified` is not success. An allowed change passes when
the observed state is either `preserved` or `changed`, but any changed region
still needs an authorized disposition or synthesized-segment explanation.
`not_applicable` is valid only when the policy declared it.

The evidence envelope has `ok: true` only when:

1. source and output descriptors verify;
2. the output partition is complete and byte-valid;
3. every source segment is byte-identical;
4. every synthesized or marker segment is authorized;
5. every protected region is mapped or permissibly disposed;
6. every required property passes;
7. no blocking preservation diagnostic remains.

There is no scalar preservation score. Aggregate tools report property and
region counts separately; passing evidence cannot compensate for one failed or
unverified required property.

## Whitespace, gaps, and line endings

Whitespace is source when it already exists. A retained layout gap uses the
exact Slice 1024 gap range and digest. Recreating the same number of blank lines
with different bytes, indentation, or line endings is a failure.

Mixed line endings are preserved when required. A synthesized segment declares
the policy or neighboring source fragment from which its line ending was
chosen. Whole-output newline normalization is permitted only when
`line_endings` is `allowed_to_change`, and the changed regions remain explicit.
Final-newline state is evaluated independently.

Encoding and BOM changes follow the same rule. Parsing decoded text does not
authorize transcoding the output. Byte ranges and digests remain relative to
the original encoded byte streams.

## Unknown and parser-specific syntax

Unknown fields and opaque or parser-specific syntax are not disposable trivia.
When required, they must be retained as exact source fragments. If safe
ownership or placement cannot be determined, the operation returns a
structured conflict or unsupported diagnostic. A provider MUST NOT normalize,
pretty-print, or drop unknown bytes merely because its portable AST projection
does not understand them.

Native providers may add richer preservation claims in namespaced extensions.
Those claims cannot weaken portable required properties.

## Integration with operations and rendering

The Slice 1019 render report is the producer-side record. This evidence is the
post-render verifier. An operation result references or embeds one preservation
policy and one evidence envelope; it does not copy the render plan into a new
shape. Segment IDs should reference render fragments, change decisions,
analysis regions, and conflicts so a reviewer can traverse the full decision.

`diff2` may report preservation evidence for compared source regions without
an output partition. `merge2` and clean `merge3` results require a complete
output partition whenever `source_regions` is required. Conflicted output uses
the same partition, including explicit conflict-marker segments.

A required preservation failure makes the containing operation unsuccessful.
Fallback output is judged under the same policy and cannot erase earlier
failure evidence.

## Alef and FFI transport

The evidence envelope contains only IDs, enums, byte ranges, digests, arrays,
maps, and optional inline bytes. Large content may use the same
content-addressed local references as Slice 1024. Process-local parser objects,
Ruby strings with implicit encoding state, and native AST handles never replace
portable evidence.

## Conformance

The canonical fixture MUST prove:

1. output assembled from multiple revisions maps every byte exactly;
2. a retained comment, CRLF layout gap, current-only field, and final newline
   preserve their original bytes;
3. changed semantic content has an explicit source disposition;
4. synthesized syntax identifies bytes, producer, reason, and authorization;
5. output partition gaps and overlaps are rejected;
6. digest or source/output equality mismatches are rejected;
7. blank-line counts cannot substitute for exact gap bytes;
8. required line-ending normalization, comment loss, unknown-field loss, and
   unverified properties fail;
9. semantic equivalence cannot waive preservation failure;
10. no scalar score can convert failed evidence to success.

## Non-goals

- defining semantic equivalence;
- deciding which owner or revision wins;
- reconstructing source from a normalized AST;
- replacing Slice 1019 rendering or Slice 1024 gap ownership;
- requiring every native provider to expose identical AST details;
- treating optional formatting as an implicit post-merge step.
