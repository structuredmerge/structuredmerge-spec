# Slice 1029: Provider Contract Snapshot Manifest

## Status and scope

This slice defines how observed parser/provider behavior is admitted as
portable contract evidence. It inventories the representative TSLP, Prism,
Psych, RBS, Markdown, TOML, and YAML snapshots required by Phase 3 and prevents
hand-authored expectations from being mislabeled as golden-master captures.

The contract identifier is
`structuredmerge.provider-snapshot-manifest/v1`.

The manifest references Slice 1024 parse/analysis artifacts, Slice 1025
operation artifacts where captured, and namespaced provider extensions. It does
not define another parse result, normalize native ASTs into a lowest common
denominator, or select a provider.

## Snapshot admission states

Every matrix row has one state:

- `observed`: captured from a pinned runnable producer and deterministically
  replayed;
- `provisional`: useful existing fixture or manually reviewed expectation that
  lacks complete observed-capture provenance;
- `pending`: target is defined but no candidate artifact is admitted;
- `rejected`: a candidate was captured but failed integrity, replay,
  compatibility, or review.

Only `observed` rows satisfy the representative snapshot exit condition.
Provisional artifacts remain valuable migration inputs, but they cannot prove
that serialization preserves current Ruby behavior.

## Provider and parser identity

Each row keeps workflow-provider selection separate from TreeHaver parser
selection. It contains:

- snapshot ID, family, language, dialect, and scenario;
- workflow provider ID, package, version, role, and capabilities;
- parser backend ID, backend family, package/version, parser/grammar identity,
  and capabilities;
- requested and selected profile/selection metadata;
- capture state and admission reason.

Rows may share a workflow provider while selecting different parser backends,
as with RBS native and TSLP scenarios. Installing a parser-specific provider
does not authorize an unrelated workflow provider to select it.

## Producer provenance

An observed row records:

- Ruby golden-master release and source commit;
- clean/dirty source state;
- artifact or installed-gem digest;
- exact package and dependency versions;
- Ruby engine/version/platform and operating-system architecture;
- configuration and environment digest with secrets excluded;
- capture adapter ID/version/source digest and command or operation envelope;
- fixture repository revision and capture timestamp.

Timestamp is provenance only and never contributes to artifact identity.
Dirty or uncommitted producer state is inadmissible unless every changed byte is
captured as a content-addressed producer artifact and explicitly reviewed.

## Inputs and artifacts

Every input has an exact Slice 1024 source descriptor or a local fixture
reference with byte length and SHA-256. Capture is offline after inputs and
artifacts are materialized.

An observed row contains or references:

- parse request and parse result;
- analysis result when the workflow exposes analysis;
- optional diff2, merge2, or merge3 request/result pairs for the scenario;
- diagnostic and preservation evidence when applicable;
- source fixture and producer manifest;
- extension payloads or extension references.

Each artifact has kind, schema, local path or content-addressed reference, byte
length, SHA-256, and canonicalization mode. `exact_bytes` is preferred.
Canonical JSON may be used for semantic replay only when the exact raw artifact
is retained separately.

Artifact paths are repository-relative and cannot escape the corpus root.
Network references are provenance, not permission to fetch during validation.

## Normalized and native evidence

Every observed parser row satisfies the normalized Slice 1024 fields its
capabilities advertise. Native providers additionally retain extension
evidence containing:

- extension schema, namespace, and version;
- sorted declared capabilities;
- exact payload or content-addressed payload digest;
- normalized node/owner references the extension augments;
- opaque-forwarding replay digest;
- visibility of any live native tree (`provider_internal` or negotiated
  in-process handle).

A process-local native handle is never serialized as portable data. Conversely,
the absence of a serializable native handle is not permission to discard native
facts. Provider extensions preserve Prism directives, Psych aliases/tags,
RBS type details, Markdown source positions/attributes, and other capabilities
that have no honest universal field.

The normalized projection and native extension are complementary. A snapshot
is rejected if normalization changes native facts, if forwarding drops unknown
extension fields, or if a consumer must deserialize a native class to read the
portable projection.

## Determinism and replay

Observed capture runs at least twice in fresh processes with identical inputs,
producer, registry snapshot, and configuration. The manifest records replay
count and exact or canonical artifact digests for every run.

Allowed nondeterministic provenance fields, such as capture timestamp and
process ID, are excluded before canonical comparison and listed explicitly.
Node IDs, child order, diagnostic order, owner order, extensions, ranges,
digests, and semantic results are not excludable.

Replay failure changes the row to `rejected`; selecting one convenient run is
invalid.

## Representative matrix

The initial matrix requires at least:

1. JSON through TSLP/tree-sitter;
2. Ruby through native Prism, including comment/directive extension evidence;
3. YAML through native Psych, including anchors, aliases, tags, and documents;
4. RBS through the native RBS parser with type-specific extension evidence;
5. Markdown through the preferred native Markdown provider;
6. TOML through TSLP/tree-sitter;
7. YAML through TSLP/tree-sitter.

Additional rows compare alternate Markdown, TOML, YAML, RBS, or Ruby backends.
They do not replace the required representative row unless the matrix revision
explicitly changes the preferred provider target.

## Review and compatibility

Admission records reviewer, review state, findings, and superseded snapshot ID.
A provider/package upgrade creates a new immutable snapshot row or revision; it
does not silently rewrite historical producer identity.

Compatible consumers preserve unknown fields and extension payloads. Unknown
major schemas, missing producer identity, unresolved source/artifact digests,
or capability claims unsupported by artifacts reject admission.

## Conformance

The manifest fixture MUST prove:

1. all seven representative rows exist exactly once;
2. workflow provider and parser backend identity remain separate;
3. observed status requires complete pinned producer provenance;
4. provisional fixtures do not satisfy the observed matrix;
5. every referenced local artifact has a verified digest;
6. native rows declare extension capture requirements;
7. extension forwarding and deterministic replay are mandatory;
8. pending rows identify exact capture targets and missing evidence;
9. matrix completeness depends only on admitted observed rows;
10. hand-authored, dirty, nondeterministic, path-escaping, lossy-extension, and
    unverifiable captures are rejected.

## Non-goals

- capturing artifacts during fixture validation;
- treating expected fixture output as observed runtime evidence;
- flattening every native AST into one tree shape;
- serializing process-local parser objects;
- choosing preferred providers at runtime;
- allowing network-dependent snapshot replay.
