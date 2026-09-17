# Typed WorkflowHost boundary

This is the initial in-process Rust boundary in `structuredmerge-core`, built on
the merge-provider registry and TreeHaver selector. It is not a separate host
package, a JSON-string facade, or a claim that host-owned semantics moved to Rust.
Ruby/Python generation and installed-runtime validation remain open.

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

Alef-generated Ruby/Python trait bridges, native provider implementations,
installed artifact tests, host availability, versioned parser profiles,
family-default dispatch, allowed delegation and full portable batch/capability
conformance remain open. Callback thread affinity, active-runtime shutdown and
broader concurrency/stress guarantees are not established by Rust trait bounds.
Existing explicit kernel profiles remain unchanged, with no default promotion
or prototype publication requirement.
