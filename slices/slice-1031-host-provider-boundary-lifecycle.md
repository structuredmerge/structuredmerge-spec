# Slice 1031: Host Provider Boundary and Lifecycle

## Status and scope

This slice tightens Slice 1030's Alef host-provider mode. It defines coarse
batch calls, registration and removal, registry snapshots, runtime affinity,
ownership, cancellation, error fidelity, framing, limits, and shutdown. It does
not choose the final wire codec or claim that a generated bridge has passed the
Ruby prototype gate.

## Alef mechanics being composed

Alef trait bridges can generate host wrappers that validate required methods,
retain an opaque host object, implement a Rust trait, wrap the implementation in
`Arc<dyn Trait>`, and register it through a configured registry getter. Trait
bridge configuration also supports unregister and clear functions. C-FFI
bridges generate a vtable, user data, and `Drop` through `free_user_data`.

StructuredMerge owns the semantics around those mechanisms: descriptors,
capabilities, immutable registry snapshots, operation identities, runtime
executors, limits, source digests, diagnostics, and fail-closed behavior.
Generated code must call these owned APIs rather than introduce an independent
global registry or lifecycle policy.

## Bridge traits

The generated host surface contains two provider interfaces:

### Parser host

- `descriptor() -> ProviderDescriptorEnvelope`;
- `probe_batch(ProbeBatchEnvelope) -> ProbeBatchResultEnvelope`;
- `parse_batch(ParseBatchEnvelope) -> ParseBatchResultEnvelope`.

### Workflow host

- `descriptor() -> ProviderDescriptorEnvelope`;
- `execute_batch(OperationBatchEnvelope) -> OperationBatchResultEnvelope`.

One method call handles one bounded batch. A workflow host performs parse,
analysis, merge classification, rendering, and verification inside its host
stack when that is what its provider implements. Rust does not decompose the
call into node, owner, decision, or render callbacks.

Descriptor data is validated and cached at registration. Probe may refresh
availability but cannot mutate identity or advertised capabilities. A changed
descriptor requires a new registration generation.

## Handshake and framing

Registration negotiates:

- bridge protocol major/minor;
- supported semantic schema versions;
- supported codecs and selected codec;
- inline and total batch byte limits;
- detached local-blob support;
- compression support, disabled by default;
- cancellation granularity;
- threading and reentrancy contract.

The prototype may use canonical JSON for headers and result envelopes. Exact
source bytes travel as byte fields or detached content-addressed local blobs so
text encoding and line endings are not altered by JSON conversion. The final
codec remains unfixed until correctness and overhead measurements compare at
least generated typed values and one coarse encoded-envelope path.

Each encoded frame contains protocol version, codec, semantic schema, batch ID,
payload byte length, and SHA-256. The receiver validates limits before
allocation, then digest, schema, batch identity, and item identities before
dispatch. Trailing bytes, duplicate item IDs, unknown major versions, path
escape, remote blob fetches, and digest mismatches fail closed.

## Registration

A registration request contains registration ID, provider kind, complete
descriptor, negotiated bridge contract, host-runtime identity, and optional
expected registry generation.

Registration:

1. validates all required host methods;
2. invokes and validates `descriptor` on the runtime-affine executor;
3. validates stable ID, provider kind, contracts, capabilities, and limits;
4. rejects duplicate stable IDs unless an explicit atomic replacement contract
   names the expected prior generation;
5. creates the bridge wrapper and runtime executor;
6. inserts `Arc<dyn ParserProvider>` or `Arc<dyn MergeProvider>`;
7. publishes a new immutable registry generation and digest.

No host callback runs while a registry read/write lock is held. Registration
cannot trigger parsing, grammar warm-up, merge execution, network access, or a
fallback selection.

## Registry snapshots and removal

An operation captures parser and merge registry snapshots before selection.
Those snapshots hold strong provider references for the operation lifetime.

Unregister removes a provider from future snapshots and publishes a new
generation. In-flight operations using an older snapshot may finish unless
explicit cancellation policy stops them. Removal does not invalidate their
bridge pointers or host objects.

After the last snapshot/call lease drops, finalization is queued on the owning
runtime executor. A Ruby object is not dropped from an arbitrary Rust worker.
C-FFI `free_user_data` runs exactly once after no callback can observe the
vtable/user data. `clear` is reserved for controlled test reset or process
shutdown and follows the same lease/finalization rules.

Atomic replacement is register-new then publish-new-generation then retire-old.
There is no interval where an explicit stable ID resolves to a partially
constructed provider.

## Runtime affinity and concurrency

Every host registration owns a `RuntimeExecutor`. Its descriptor declares:

- `serialized`, `concurrent`, or `runtime_affine` dispatch;
- maximum in-flight calls and batch items;
- reentrancy support;
- whether callbacks may block;
- cancellation granularity;
- finalization executor.

The Rust wrapper may implement `Send + Sync` because dispatch is queued; the
underlying host object need not. Ruby calls and finalization occur through the
verified Magnus/runtime path with the required GVL behavior. A generated code
comment is not proof of safe GVL/thread behavior; the prototype must test calls
from Rust workers, host exceptions, nested calls, unregister during flight, and
shutdown.

Providers are not called while registry, source-store, diagnostic, or output
locks are held. Host callbacks may not synchronously mutate their own registry
generation. Reentrant operation dispatch is rejected unless explicitly
advertised and tested.

## Ownership and host leases

Request and result envelopes are owned values. Inline source bytes are copied
or moved into the bridge frame. Detached blobs are immutable local files or
shared regions identified by source ID, length, digest, and lease ID.

The receiver obtains a read lease before dispatch and releases it after result
validation. It cannot retain a blob reference beyond the declared lease without
renewal. Cleanup never deletes caller-owned source paths.

Native parser trees remain host-owned. A negotiated opaque lease token may let
later calls in the same provider session refer to host state, but the token:

- is scoped to one registration and session;
- carries no pointer or host object ID semantics;
- has expiry and explicit release;
- is never used in portable fixtures, caches, or cross-provider calls;
- cannot replace normalized, source, diagnostic, or extension evidence.

The first prototype SHOULD avoid host leases and prove complete owned-envelope
round trips before adding them.

## Cancellation, deadlines, and limits

Execution control contains absolute deadline, cancellation token ID/state,
maximum input/output bytes, maximum batch items, maximum diagnostics/conflicts,
and optional CPU/memory guidance.

The bridge checks before enqueue, before host invocation, between batch items
when the host adapter supports it, and after return. Cancellation is
cooperative; it does not free host state while a callback is running. A result
completed after cancellation is validated for memory safety but classified
according to the cancellation contract rather than silently accepted.

Deadline and cancellation diagnostics follow Slice 1028. Oversized frames are
rejected before full allocation. Output overrun is a bridge/provider fault; the
result is not truncated into apparently valid JSON or source.

## Error fidelity

Failure layers remain distinct:

- registration/handshake failure;
- unavailable runtime or retired provider;
- enqueue/dispatch failure;
- codec/frame/schema failure;
- provider-returned operation failure;
- panic, host exception, or process loss;
- cancellation/deadline/resource failure.

If the host returns a complete valid provider result, its diagnostics,
conflicts, preservation evidence, and `ok` remain authoritative. A bridge does
not replace them with a generic exception. If transport fails before a complete
result exists, Rust emits a Slice 1028 diagnostic with bridge origin, stable
code, causal native error data, and no fabricated merge output.

Host exception messages and backtraces are debug evidence, redacted by default,
not stable codes. Panic/exception containment marks the individual call failed;
the registration is marked unavailable only when health policy proves the
runtime/provider is no longer safe.

## Shutdown

Shutdown stops new registrations and dispatch, publishes registries without
host providers, requests cancellation, waits a bounded drain interval, and
then finalizes retired providers on their runtime executors. Timeout produces a
diagnostic and explicit forced-runtime-shutdown state. It does not pretend every
provider was cleanly dropped.

Shutdown is idempotent. Registration/unregistration during shutdown is rejected.
All detached blob leases and host lease tokens are accounted for in the final
report.

## Prototype gate

Before fixing the ABI, the Ruby/Magnus prototype MUST test:

1. registration method validation and descriptor validation;
2. parse and operation batches containing exact CRLF and non-ASCII bytes;
3. provider-returned parse failure, conflict, and preservation failure;
4. host exception and malformed/oversized result containment;
5. calls from multiple Rust workers through runtime-affine dispatch;
6. cancellation before, during, and after dispatch;
7. unregister and atomic replace while calls are in flight;
8. finalization and clear/shutdown exactly once;
9. unknown extension round trip;
10. callback count and serialization/copy overhead measurement.

## Conformance

The fixture MUST reject per-node callbacks, unlocked lifetime transitions,
registry-lock callbacks, arbitrary-thread host access, early user-data free,
identity mismatch, unbounded frames, source transcoding, remote blob fetch,
provider-diagnostic erasure, silent fallback after runtime loss, and clean
shutdown claims after forced termination.

## Non-goals

- fixing a stable codec or ABI;
- implementing runtime-specific thread/GVL internals in this spec;
- serializing native AST objects;
- permitting network artifact fetch during dispatch;
- using host callbacks as a replacement for TreeHaver selection;
- decomposing one merge into fine-grained FFI callbacks.
