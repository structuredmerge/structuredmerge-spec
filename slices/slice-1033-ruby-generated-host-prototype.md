# Ruby Generated Host-Provider Prototype

## Status and scope

This slice defines the first executable Alef host-provider prototype. It uses
Ruby because the Ruby implementation is the golden master and exposes the
highest-value native workflows. It composes Slices 1024 through 1032 and tests
Alef's generated Magnus trait bridge rather than TSLP's existing exported
function bindings.

This document is an acceptance harness, not proof that the prototype has run.
The Phase 4 prototype task remains open until generated code compiles and every
required runtime test emits captured evidence.

## Audited baseline

The prototype is initially pinned to Alef revision
`eebd7619b9c8217b16d2ee9b287738ce6c97dda9`. At that revision:

- Magnus generates wrappers containing `Opaque<magnus::Value>`;
- registration validates required Ruby methods, wraps the object in
  `Arc<dyn Trait>`, and calls a configured registry getter;
- unregister and clear forward to configured Rust lifecycle functions;
- synchronous and asynchronous trait methods use different generated paths;
- native generated DTOs and JSON-mediated named values are both supported;
- TSLP's current Alef IR contains zero traits and zero services, so its Ruby
  extension does not test inbound Ruby provider registration.

The generated async template contains a claim about GVL acquisition around
`Ruby::get_unchecked`. The prototype MUST verify Magnus-supported runtime entry
and GVL behavior. Generated comments and successful code generation are not
thread-safety evidence.

## Prototype packages

The minimum prototype has three pieces outside the canonical Ruby source tree:

1. `structuredmerge-host-prototype-core`, a Rust crate containing the temporary
   object-safe traits, owned envelope DTOs, registry, identity Rust provider,
   dispatch counters, and evidence recorder;
2. an Alef-generated Magnus extension exposing registration, unregister, clear,
   identity execution, and evidence retrieval;
3. a Ruby harness defining parser-host and workflow-host objects and driving the
   generated extension.

Temporary prototype traits mirror Slice 1030 but do not become the final public
ABI. The crate and generated output are explicitly marked experimental. No code
is copied into SM Ruby during its release.

## Generated interfaces

The prototype generates both host traits from Slice 1031:

### Parser host

- `descriptor() -> ProviderDescriptorEnvelope`;
- `probe_batch(ProbeBatchEnvelope) -> ProbeBatchResultEnvelope`;
- `parse_batch(ParseBatchEnvelope) -> ParseBatchResultEnvelope`.

### Workflow host

- `descriptor() -> ProviderDescriptorEnvelope`;
- `execute_batch(OperationBatchEnvelope) -> OperationBatchResultEnvelope`.

Every method is fallible. The host cannot trigger a default value after a Ruby
exception, failed conversion, join failure, malformed result, or missing
required method. An Alef path that only supports infallible fallback behavior is
rejected or fixed upstream before use.

Registration functions accept the Ruby object plus a registration request that
contains the stable provider ID, expected registry generation, bridge contract,
and limits. A user-supplied display name is not the provider identity.

## Two transport candidates

The same semantic cases execute through two generated surfaces:

- `generated_typed_values`: generated Ruby DTOs carry headers and ordinary
  fields; exact source payloads remain byte strings with explicit length and
  digest;
- `canonical_json_detached_bytes`: canonical JSON carries the versioned
  envelope while exact source payloads use verified byte fields or local
  detached blobs.

Both candidates produce the same semantic result and preservation evidence.
Neither may call `to_json` on arbitrary host objects as an undocumented fallback
that changes types, encodings, field presence, or ordering.

## Golden-master operation

The first workflow operation is identity rendering, not a reduced merge. It
accepts an operation batch and returns each source byte-for-byte with complete
Slice 1027 evidence. This isolates bridge correctness from merge policy while
still exercising the real operation envelope.

The corpus includes:

- empty input;
- LF, CRLF, and no-final-newline files;
- invalid UTF-8 and embedded NUL bytes;
- non-ASCII UTF-8 with Ruby encoding metadata recorded separately;
- leading, interior, and trailing blank lines;
- comment-only and unknown-syntax regions;
- one input above the inline threshold using a detached local blob;
- a multi-item batch with distinct operation and source IDs.

The Rust in-process identity provider runs the same corpus. Results compare
source hashes, segment partitions, diagnostics, extension preservation, and
serialized envelopes. Equality does not require native Ruby objects to cross
the boundary.

## Lifecycle and failure matrix

The executable harness tests:

1. required-method rejection before registry publication;
2. descriptor identity, contract, capability, and limit validation;
3. successful registration and immutable generation publication;
4. duplicate rejection and generation-checked atomic replacement;
5. sync invocation on the initialization thread;
6. dispatch from multiple Rust workers through the runtime-affine executor;
7. async generated invocation when supported by the selected trait shape;
8. Ruby exception and malformed/unconvertible return fidelity;
9. cancellation before enqueue, before invocation, during a batch, and after
   host return;
10. unregister during an in-flight call and completion through the old snapshot;
11. clear in controlled test teardown;
12. runtime-affine finalization exactly once after all call/snapshot leases;
13. bounded shutdown and forced-shutdown reporting;
14. sidecar process loss without provider substitution;
15. stale generation and stale preflight rejection.

Tests include a watchdog so deadlocks become bounded failures with captured
thread/runtime state. They run under a sanitizer-capable Rust profile where
available and under Ruby GC stress. Ruby objects are not touched or finalized
from arbitrary Rust workers.

## Thread/GVL gate

Before any performance conclusion, the generated bridge MUST demonstrate:

- every Ruby API call occurs on a Magnus-supported thread with the GVL;
- `Opaque<Value>` is only resolved under that valid runtime context;
- blocking Rust work releases the GVL only through a documented safe API;
- callbacks reacquire or schedule onto Ruby through a documented safe API;
- no callback occurs while a StructuredMerge registry/source/output lock is
  held;
- panic and Ruby exception boundaries cannot unwind across FFI;
- finalizers execute on the owning runtime and exactly once.

If stock Alef output fails this gate, the failure is reduced in Alef's own test
suite and fixed there. StructuredMerge MUST NOT add a handwritten competing
Magnus bridge generator.

## Measurement protocol

Measurements compare in-process Rust identity, generated typed values, and
canonical JSON with detached bytes. Release builds use the same machine, corpus,
warm-up, batch sizes, and provider implementation.

For each transport and batch size, capture:

- total and per-item wall time distributions (`p50`, `p95`, `p99`);
- calls per batch and callbacks per operation;
- bytes copied, serialized, and detached;
- allocations when measurable;
- peak resident memory;
- GVL hold and wait time when measurable;
- registration, first-call, warm-call, unregister, and shutdown costs;
- output and preservation digest equality.

Batch sizes include 1, 8, 32, and the negotiated maximum. Payload classes
include small inline, medium inline, and above-threshold detached bytes. At least
30 measured samples follow warm-up. Raw samples and environment metadata are
retained; summaries alone are insufficient.

No universal performance threshold is fixed before measurement. Correctness,
source preservation, bounded memory, coarse callback count, and lifecycle safety
are hard gates. The chosen transport must then have documented overhead suitable
for interactive CLI use and batch templating.

## Evidence artifact

One machine-readable report records:

- source, Alef, Rust, and Ruby revisions and dirty state;
- toolchain, target, CPU, operating system, and build profile;
- generated-file hashes and generation command;
- trait and schema versions;
- each correctness/lifecycle case with status and diagnostic;
- raw measurement artifact paths and SHA-256 digests;
- callback/copy counters;
- sanitizer and GC-stress status;
- selected transport decision or explicit `undecided`;
- discovered Alef defects and linked upstream reproductions.

Evidence is invalid if generated files were manually edited, the repository was
dirty without a recorded diff digest, a case was skipped without a reason, or
source bytes were reconstructed from normalized text.

## Exit gate

The Phase 4 prototype item completes only when:

1. Alef generates and the extension compiles from a clean command;
2. both Rust and Ruby identity providers register through the same kernel traits;
3. the full byte corpus round-trips with exact preservation evidence;
4. all lifecycle and failure cases pass or are explicitly blocked by an upstream
   issue with no unsafe workaround enabled;
5. callback and serialization/copy measurements exist for both candidates;
6. one transport is selected or the evidence explains why more work is needed.

The broader Phase 4 exit gate still requires the Rust TSLP provider and Ruby host
provider to round-trip through one no-op operation without hidden fallback.

## Non-goals

- porting Psych, Prism, RBS, or full ast-merge behavior in this prototype;
- editing the canonical Ruby implementation during its release;
- stabilizing crate names, ABI, codec, or public package layout;
- using TSLP's exported Ruby API as a substitute for an inbound trait bridge;
- accepting generated-code compilation without runtime evidence;
- working around unsafe Alef output in a StructuredMerge-only generator.
