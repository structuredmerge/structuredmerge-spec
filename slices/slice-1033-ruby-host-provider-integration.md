# Slice 1033: Ruby Host-Provider Integration

## Status and scope

This slice defines integration and conformance evidence for invoking the Ruby
host providers from the StructuredMerge Rust runtime through the Alef-generated
Magnus bridge. It composes Slices 1030-1032; it does not define another
provider API, package, transport, or lifecycle model.

The bridge and Ruby host implementation belong in their canonical production
components. Tests belong in those components' existing test suites, and
portable request/result cases belong in the shared `structuredmerge/spec`
fixtures. This work MUST NOT create a throwaway prototype package, parallel
bridge generator, or temporary copy of the provider traits.

This slice is an integration gate, not a claim that the bridge is implemented
or has passed. Completion requires executable evidence from the production
integration path.

## Integration boundary

The Ruby host implements the parser-provider and workflow-provider contracts
from Slice 1031 using the operation and result envelopes from Slices 1024-1028.
The Rust runtime selects and calls it through the same registries and
capability policy used for other providers. It MUST NOT add a Ruby-only
selection path, hidden fallback, or second registry.

The implementation uses the single wire format and generated surface selected
by the StructuredMerge provider design. This slice does not require parallel
typed-value and JSON implementations. Exact source bytes, schema versions,
diagnostics, extensions, and preservation evidence retain the semantics
defined by their owning slices regardless of transport.

Alef-generated bindings are the only Ruby-to-Rust bridge in this integration.
Generated files are produced by the pinned, documented generation command and
are not hand-edited. Magnus runtime entry, GVL, exception, and finalization
requirements remain those defined by Slice 1031; successful code generation
alone is not evidence that those requirements hold.

## Required integration cases

The existing production test suites MUST exercise the generated bridge and
canonical provider implementation together. Coverage includes:

1. Register a Ruby parser host and workflow host using valid descriptors, then
   dispatch bounded batches through the Rust registries.
2. Reject a host with missing required methods or an invalid descriptor before
   publishing it to a registry.
3. Execute at least one agreed no-op operation through the real operation
   envelope and verify its result and preservation evidence end to end. Do not
   invent a test-only provider API or treat a byte-copy helper as a merge
   operation.
4. Preserve exact bytes for empty input, LF and CRLF input, missing final
   newline, non-ASCII UTF-8, invalid UTF-8 where the contract permits it, and
   embedded NUL bytes where the operation permits them.
5. Preserve structured provider errors, conflicts, diagnostics, and unknown
   compatible extension fields across the bridge without fabricating a
   successful result or replacing provider diagnostics with generic errors.
6. Exercise host exceptions, conversion failures, malformed results, and
   oversized results; each fails closed at the appropriate bridge or provider
   boundary.
7. Exercise runtime-affine dispatch, cancellation, unregister or replacement
   during an in-flight call, and shutdown using Slice 1031's lifecycle
   semantics.

Tests MUST use the actual generated Magnus bridge and production registry.
Mocks may isolate individual Rust or Ruby units, but cannot substitute for the
end-to-end integration cases above.

## Conformance and safety

The bridge conforms only when the integration tests demonstrate that:

- calls are batched at the provider-operation boundary rather than dispatched
  per node or per edit;
- Ruby API access, `Opaque<Value>` resolution, callbacks, and finalization obey
  the runtime-affinity and GVL rules in Slice 1031;
- no host callback runs while StructuredMerge registry, source, diagnostic, or
  output locks are held;
- exceptions and panics cannot unwind across FFI;
- source bytes are not transcoded or reconstructed by the bridge;
- loss of a host provider cannot silently select a different provider.

These are conformance requirements, not permission to add handwritten
threading or lifecycle machinery around generated bindings. If the generated
bridge cannot meet them, reduce the failure in the generator's own tests and
fix the generator or its configuration before claiming Ruby host support.

## Evidence

The integration evidence is produced by the owning production tests and
existing benchmark/test reporting. Record enough provenance to reproduce it:

- StructuredMerge, Alef, Magnus, Rust, and Ruby revisions and dirty state;
- toolchain, target, operating system, and generation command;
- generated-file hashes and the selected envelope/transport version;
- status and diagnostic for each required integration case;
- test, sanitizer, and GC-stress results where supported;
- callback count, bytes copied/serialized, and representative latency for the
  selected production path when benchmark infrastructure is available.

Do not create a new package or permanent evidence subsystem solely for this
slice. Generated artifacts and test reports follow the existing repository and
CI conventions of their owning components.

## Exit gate

This slice is complete when:

1. the canonical Rust runtime, generated Magnus bridge, and Ruby host provider
   build and run together from the documented production build;
2. the required success, byte-preservation, diagnostic, failure, and lifecycle
   cases pass through that integration;
3. generated bindings are reproducible and unmodified by hand;
4. evidence identifies the exact source/toolchain revisions and test results;
5. the broader Slice 1032 gate can exercise the Ruby host provider through one
   no-op operation without hidden fallback.

## Non-goals

- creating a prototype or temporary package/crate;
- duplicating Slice 1031's generic provider, transport, or lifecycle contract;
- evaluating multiple wire formats in a parallel throwaway implementation;
- porting full Psych, Prism, RBS, or ast-merge behavior as part of this
  integration gate;
- stabilizing package names or public ABI beyond the decisions owned by
  Slices 1030-1032.
