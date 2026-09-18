# Typed WorkflowHost boundary

This is the initial in-process Rust boundary in `structuredmerge-core`, built on
the merge-provider registry and TreeHaver selector. It is not a separate host
package, a JSON-string facade, or a claim that host-owned semantics moved to Rust.
Alef generates Ruby/Python bindings for this boundary. Isolated installed
artifact tests exercise LibCST/Psych analysis over prepared two-operation
batches, source identity, typed results and shared callback cancellation.
These are boundary checks, not native merge parity or publication approval.

## Responsibilities and transport

`WorkflowHost` supplies a typed merge-provider descriptor and one coarse
`execute_batch` callback. The callback receives a batch of existing typed
`OperationRequest` values, source-bound `CoreParseResult` records, per-operation
selection reports and a shared `OperationControl`. The ordinary operation/result
schemas remain authoritative; these owned batch DTOs do not define a second
portable operation protocol. The portable batch/capability envelope remains a
separate conformance gate.

Permanent host capabilities are parsing, native syntax information and declared
provider-specific analysis. A whole-merge callback is transitional host-owned
behavior. `WorkflowExecution` is assembled by the kernel with execution owner
`host` and `approved_as_default: false`, plus the cached provider identity and
selection evidence. A callback cannot grant itself kernel ownership or authority.
Passing transport validation does not prove the callback's semantic claims.

## Dispatch

### Source-free selection observations

`workflow_selection_reports(queries, limits)` and its controlled variant expose
the existing `MergeSelectionRequest`/`MergeSelectionReport` selector through the
typed facade. They accept no source documents and never parse, merge, render,
or invoke a workflow callback. TreeHaver parser probes are still callbacks:
their registered policy may load/acquire grammars. Offline callers must register
cached-only providers; these APIs are not implicit permission for CLI preflight
to acquire assets.

One workflow snapshot and one parser snapshot serve the entire query batch.
Every query and compiled-profile parser constraint is validated before any
probe, using the same validation as workflow execution. `WorkflowLimits` bounds
query count and serialized request/response sizes; shared execution control is
checked throughout. Empty responses also obey the response-byte budget.
Response-size checks bound accepted/accumulated reports, not arbitrary native
callback allocations or intermediate selector allocation. Deadlines remain
cooperative, not a way to preempt a blocked callback.

Reports preserve candidate ordering/rejections and both generations/digests.
An absent or ineligible provider yields an unselected report; malformed requests,
limits and control failures return `CoreError`. Registry changes during a probe
affect later calls, not later queries in the captured batch. No availability
cache or lease is created, and the report cannot authorize a future execution.

These are source-free selection observations, not the complete Slice 1026
portable envelope or Slice 1032 authenticated availability/preflight evidence.
They do not verify artifact/asset signatures, workflow health, source-specific
support or default authority. CLI language availability must not substitute these
reports for its remaining manifest, health and staleness gates.

### Execution

The additive `execute_workflow_batch_at_registry` and controlled variant accept
`WorkflowRegistryExpectation`: provider generation/digest and parser
generation/digest, using the identities exposed by selection reports. They
capture the normal execution snapshots and require all four values to match
before probes, source parsing or workflow callbacks. Mismatch returns
`workflow.registry_stale`, including unregister/re-register cycles with identical
descriptors. The request and expectation share a combined serialized request
budget; cancellation is checked before registry validation and execution.

After acceptance, the same captured handles feed normal validation, negotiation
and execution. Later registry changes affect later calls, not the in-flight
batch. This does not promise an atomic transaction across the two registries or
cancel an accepted batch when a registration is subsequently retired. Existing
unguarded APIs retain their behavior.

This guard constrains registry state only. Expectations are caller input, not
authenticated authority; they do not pin an artifact, policy, selected backend,
probe result, host health or loaded grammar digest. Normal negotiation and its
execution-time backend pin still apply. This API MUST NOT be represented as
successful Slice 1032 preflight or used to bypass its other requirements.
Generations are meaningful only within the originating registry instance.
Expectations are process-local concurrency checks, not replay protection across
process restarts or independent registries with equal declarations/counters.

- Registration obtains the descriptor outside locks and caches it in the
  `ast-merge` registry. Duplicate IDs fail. Replacement/removal require the
  observed generation. Inventory does not invoke callbacks.
- Initial dispatch requires an explicit provider argument. A conflicting provider
  ID in any operation is rejected. No family-default execution or delegation is
  inferred, and callback failure never retries another provider.
- The complete batch is checked before probes: nonempty/unique request IDs,
  common request/source validation, inline content or bytes only, cumulative
  source-byte budget, operation/source cardinality and valid selection queries.
  Source references never trigger implicit filesystem/network access.
- Parser language/dialect and parse options are explicit. Provider constraints
  enter TreeHaver's existing selector. Unsupported versioned parser constraints,
  unknown selector fields and required extension capabilities fail closed.
- Each operation's parser is selected against the captured TreeHaver snapshot,
  then pinned by ID for parsing against that same snapshot. All input parsing
  completes before the single workflow callback. A parse failure prevents it.
  Probing may occur again during parse dispatch; a now-unavailable parser causes
  failure, not substitution.
- In-flight registration retirement cannot change the cached provider/parser
  handles. Mutations affect subsequent executions.

## Budgets, results and control

### Compiled-provider batches

The same registry also retains compiled kernel executors. An explicit compiled
batch requires its implemented profile and matching profile-owned parser
language, dialect and parse options. Semantic workflow dialects map to parser
languages (for example JSONC to `json5`); the compiled native engines query
TreeHaver with no separate parser dialect. A non-null parser dialect rejects
rather than being silently discarded. All requests and query constraints are
validated before probes. It captures the same provider/parser snapshots used by
host batches and negotiates every item before semantic execution. It then calls
the existing native kernel operation engines, preserving their typed results.
The negotiated backend ID becomes a conjunctive TreeHaver service constraint for
input parsing and output verification. If that backend becomes unavailable,
execution fails without probing or executing an alternate backend. The original
request's explicit/policy selection fields are not rewritten to simulate a pin.
Results are also checked against the original validated inputs and negotiated
identity; this postcondition is not a substitute for constraining dispatch.

Kernel batches report `execution_owner: kernel`, always with
`approved_as_default: false`. Request/source and response-byte budgets and shared
execution control remain enforced. This is not host callback invocation: each
kernel operation owns parsing and output verification through TreeHaver, and
there is no fabricated prepared-host batch. Probes are observations, not leases;
parser liveness can still change between negotiation and execution. This boundary
does not claim authenticated availability or a stale-snapshot preflight protocol.

### Host callback validation

`WorkflowLimits` bounds operation count, encoded request/prepared-callback bytes,
encoded callback-response bytes and parser resources. Input bytes are cumulative
across operations; parser node/diagnostic limits retain TreeHaver semantics.
Serialization counters enforce envelope budgets without a second large buffer;
the response's already-bounded encoding is then strictly decoded to reject
reserved-field shadowing and typed/wire disagreement.

Results must match batch cardinality and request order, request identity, selected
provider/family/profile/parser, explicit-versus-policy parser selection mode, and
the existing common result validator. Undeclared delegation is rejected. Invalid
or partial callback results are not returned as successful execution.

Cancellation/deadline checks surround preparation, parsing and host execution;
late callback results and faults cannot override control failure. The callback
receives the shared cancellation signal. Calls are cooperative: this does not
preempt native code, bound arbitrary callback allocations or roll back callback
side effects. Timeout metadata is not a hard real-time guarantee.

Descriptor and workflow panics/faults have stable core error codes. Parser service
failures retain their portable code without copying native exception text into
the workflow error message. Complete portable failure envelopes with retained
selection/causality evidence remain open; the initial API returns `CoreError` on
boundary failure.

## Remaining gates

Installed Linux CPython 3.14.2/MRI 4.0.6 tests verify registry retention across GC,
release after retirement, reentrant replacement/removal, stale-generation
rejection, and in-flight snapshot identity. Sixteen overlapping calls on four
host-created threads preserve caller context. Cross-thread cancellation discards
late host results, and bounded subprocess tests verify exit with registered,
retired and cancelled-and-drained hosts. These are synchronous host-thread and
cooperative-drain observations, not guarantees inferred from Rust trait bounds.

Independently packaged native workflow providers, broader installed-runtime
coverage, host availability, versioned parser profiles,
family-default dispatch, allowed delegation and full portable batch/capability
conformance remain open. Foreign Rust-thread dispatch, abrupt VM teardown with
active callbacks, other runtimes/platforms and broader concurrency/stress
guarantees remain unproven.
Existing explicit kernel profiles remain unchanged, with no default promotion
or prototype publication requirement.
