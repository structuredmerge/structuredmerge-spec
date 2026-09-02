# Slice 1030: Rust Kernel and Provider Traits

## Status and scope

This slice defines the internal Rust architecture that will consume Slices
1024-1029 and later serve as the StructuredMerge kernel. It covers object-safe
provider traits, TreeHaver parser selection, normalized tree/source access,
diagnostics, merge policy, render/edit application, and in-process versus host
provider modes.

It is a design contract, not an implementation claim. The existing Rust crates
remain non-canonical and must not constrain behavior extracted from the Ruby
golden master.

## Findings from the current implementations

The current Rust `tree-haver` crate has a generic
`ParserAdapter<TAnalysis>` and a backend registry containing only backend
references. That shape cannot hold heterogeneous parser providers, cannot
resolve by capability metadata, and exposes an analysis type parameter where
the portable boundary needs owned parse envelopes plus optional native leases.

Its legacy normalized node duplicates source text, stores child IDs without
field edges, and uses nested string metadata. These values are migration input,
not the Slice 1024 model. The current Rust `ast-merge` crate similarly contains
many historical report structs but no uniform object-safe merge-provider
registry.

TSLP demonstrates that Alef can project a Rust crate's owned public types and
functions into many runtimes. Its current Alef IR contains no traits, services,
or handler contracts, however, because TSLP is an outbound Rust API. Structured
Merge additionally needs host runtimes to implement parser and merge providers
called by Rust. Alef trait bridges are the relevant mechanism; TSLP's generated
package layout alone does not solve this bidirectional requirement.

## Crate boundaries

The first implementation SHOULD separate:

- `tree-haver-core`: source descriptors, parser capabilities, immutable
  registry snapshots, selection, parse envelopes, normalized trees, source
  maps, and parser-provider traits;
- `ast-merge-core`: operation envelopes, workflow-provider registry, analysis,
  matching/ownership policy, diagnostics/conflicts, render plans, preservation,
  and merge-provider traits;
- `structuredmerge-host`: Alef-facing host provider descriptors, bridge
  registration, dispatch, lifecycle, and wire-codec negotiation;
- provider crates: TSLP/tree-sitter and later native Rust providers;
- host packages: generated Ruby and other runtime bindings plus handwritten
  adapters that implement generated provider interfaces.

Existing package names may be retained when these ownership boundaries can be
made clear without introducing duplicate core crates.

## Data before behavior

The portable structs from Slices 1024-1029 are owned, versioned values. Traits
operate on those values; they do not create competing request/result shapes.
Source bytes are immutable and content-addressed. Normalized nodes reference
source IDs and half-open byte spans rather than borrowing parser nodes.

Portable IDs and extension envelopes cross process/runtime boundaries. Rust
references, trait objects, `Any`, parser nodes, pointers, and host object IDs do
not.

## TreeHaver traits

### `ParserProvider`

The parser-provider trait is object-safe and heterogeneous:

```rust
pub trait ParserProvider: Send + Sync {
    fn descriptor(&self) -> &ParserProviderDescriptor;
    fn probe(&self, request: &ParserProbeRequest) -> ParserProbeResult;
    fn parse_batch(
        &self,
        request: ParseBatchRequest,
        context: &ExecutionContext,
    ) -> Result<ParseBatchResult, ProviderFault>;
}
```

`descriptor` contains stable backend ID, backend family, mode, languages,
dialects, capabilities, package/parser/grammar identity, priority metadata,
availability probe metadata, threading contract, and contract versions.

`probe` may check availability and compatibility without parsing. It has no
registration side effects. `parse_batch` consumes complete Slice 1024 requests
and returns one independently identified result per request. A provider may
load a requested grammar on demand during `probe` or `parse_batch`; a cold
grammar cache is not evidence that the language is unavailable.

The provider never selects itself and never calls another unregistered parser
as a fallback.

### `ParseService`

`ParseService` is the only parser entry used by merge code:

```rust
pub trait ParseService: Send + Sync {
    fn parser_for(
        &self,
        request: &ParseRequest,
        snapshot: &ParserRegistrySnapshot,
    ) -> Result<SelectedParser, SelectionFailure>;

    fn parse_batch(
        &self,
        request: ParseBatchRequest,
        snapshot: &ParserRegistrySnapshot,
        context: &ExecutionContext,
    ) -> ParseBatchResult;
}
```

The service implements Slice 1026 selection over an immutable registry
snapshot. Explicit backend requests never substitute. Policy selection uses
capability/profile metadata and deterministic tie breaking. Package-name checks
and language-specific hard-coded backend order do not belong here.

Merge providers receive a `ParseService`; they do not receive a TSLP parser,
Prism object, Psych tree, or backend registry map.

### `NormalizedTreeView` and `SourceMap`

`OwnedNormalizedTree` is the serializable Slice 1024 projection.
`NormalizedTreeView` is a read-only convenience trait implemented over that
owned value and optional in-process provider views. It exposes root, node by ID,
ordered child edges, comments, diagnostics, and extension envelopes. It cannot
return native parser objects.

`SourceMap` owns or references exact source bytes and descriptors. It validates
spans, slices exact bytes, computes range digests, projects byte points, and
provides line-ending/encoding evidence. All source extraction used by analysis,
rendering, diagnostics, and preservation goes through this shared API.

Normalized tree and source map are separate: a provider cannot make source
retention depend on reconstructing node text.

## AstMerge traits

### `MergeProvider`

The workflow-provider trait is object-safe:

```rust
pub trait MergeProvider: Send + Sync {
    fn descriptor(&self) -> &MergeProviderDescriptor;
    fn execute_batch(
        &self,
        request: OperationBatchRequest,
        services: &MergeServices,
        context: &ExecutionContext,
    ) -> Result<OperationBatchResult, ProviderFault>;
}
```

The request and result items are complete Slice 1025 envelopes for `analyze`,
`diff2`, `merge2`, or `merge3`. Batch order does not change request identity,
source roles, selection, diagnostics, or outcomes.

`MergeServices` supplies TreeHaver `ParseService`, immutable registry snapshots,
source storage, policy registry, diagnostic collector factory, render applier,
and preservation verifier. An in-process workflow provider uses these shared
services instead of importing a parser package directly.

Workflow provider and parser backend descriptors remain distinct. A provider
may require parser capabilities or an explicit backend profile, but cannot name
a package as a hidden parser-selection algorithm.

### `MergePolicy`

Portable policy is a versioned value. Executable policy implements an
object-safe `MergePolicy` over batches of complete decision contexts and returns
ordered decision records plus diagnostics. Batch evaluation avoids one host
callback per node.

Policy receives immutable owner/match/change evidence and cannot parse, mutate
source, render output, or silently invoke fallback. Language-specific policies
compose shared ast-merge decisions; they do not copy matching, gap, comment, or
preservation implementations.

### `DiagnosticCollector`

Diagnostics are Slice 1028 values. A collector accepts unsorted records from
parallel stages, validates references, and finalizes deterministic sequence,
IDs, causality, and operation ordering. It does not infer category or code from
message text or exception names.

Host providers return their diagnostics in complete operation results. The
Rust boundary validates and forwards them; it does not replace host diagnostics
with one generic bridge error unless transport failed before a provider result
existed.

### `RenderApplier` and `EditApplier`

`RenderApplier` consumes a Slice 1019 ordered render plan and exact source maps,
then returns output plus Slice 1027 byte evidence. It copies source fragments,
inserts authorized synthesis, and renders linked conflict fragments. It does
not parse, match, select owners, infer separators, or pretty-print values.

`EditApplier` validates a portable edit projection against expected input
digests and applies sorted non-overlapping edits. It is a projection consumer,
not a second render planner. Applying a plan and its edit projection to the same
source must produce identical bytes.

## Provider modes

### In-process Rust

An in-process provider is an `Arc<dyn ParserProvider>` or
`Arc<dyn MergeProvider>` registered directly. TSLP/tree-sitter is the first
parser provider. Provider descriptors state whether calls are concurrent,
serialized, or runtime-affine and whether in-process native leases are
available.

An optional native lease is request-scoped and capability-gated. It may contain
an `Arc<dyn Any + Send + Sync>` only when the provider proves those bounds. It
is never required for portable behavior, serialized, persisted, or exposed to a
different provider. Non-thread-safe native objects stay behind a serialized
provider executor.

### Host provider through Alef

An Alef-generated host bridge registers a host implementation behind the same
Rust trait. The Rust wrapper may be `Send + Sync` because it queues work to a
runtime-affine dispatcher; that does not make Ruby, JVM, or other host objects
thread-safe.

Two coarse host interfaces are required:

- parser host: `descriptor`, `probe`, and `parse_batch`;
- workflow host: `descriptor` and `execute_batch`.

A Ruby-native workflow such as Psych merge normally uses the workflow-host
interface. Ruby executes its existing ast-merge provider and Ruby TreeHaver
stack, preserving native AST behavior. Rust MUST NOT preparse the sources with
TSLP before invoking that host workflow.

A Rust workflow may use a host parser through Rust `ParseService` when the
returned normalized and extension evidence is sufficient. That is a separate
capability path, not an automatic replacement for the host workflow.

Per-node callbacks are forbidden. Host calls carry owned operation or parse
batches and return owned result batches. Large source/artifact blobs may use
negotiated local shared storage, but every reference remains length- and
digest-verified.

## Alef integration stance

The internal Rust traits use typed values. The first Alef prototype may bridge
one coarse encoded envelope method while trait/type support is proven across
Magnus, but the codec is negotiated and versioned. JSON, MessagePack, shared
memory, or generated typed projection are transport choices, not new semantic
contracts.

Alef's callback-bridge adapter and its trait-bridge generators are distinct.
The current generic callback adapter contains incomplete host conversions for
some runtimes; the prototype MUST exercise the actual generated trait bridge,
including Magnus registration, invocation, error conversion, and teardown,
before any ABI is fixed.

Generated code remains generated. Domain validation, provider selection,
registry semantics, and merge policy live in StructuredMerge-owned Rust and
host adapters, not Alef templates.

## Execution context

Every call receives an execution context containing request/batch identity,
deadline, cancellation state, resource limits, registry generation/digests,
trace context, and network policy. It contains no semantic fallback policy.

Cancellation is cooperative. The bridge checks before dispatch, host adapters
check between batch items and long phases, and the bridge checks after return.
Timeout/cancellation produce Slice 1028 diagnostics and no fabricated result.
Killing a runtime or abandoning a thread is not a normal cancellation strategy.

## Fail-closed rules

The kernel fails closed when:

- TreeHaver has no compatible parser provider;
- an explicit parser backend is unavailable;
- provider/backend capabilities do not satisfy the request;
- a host runtime or registered host implementation is unavailable;
- an extension required by a workflow is missing or incompatible;
- a bridge returns malformed, mismatched, oversized, or unverified envelopes;
- required source preservation cannot be proved.

It never substitutes a direct parser, generic serializer, line merge, another
operation, or another host runtime unless the request explicitly authorizes a
registered in-stack fallback that satisfies the same capability contract.

## Conformance

The architecture fixture MUST prove:

1. parser and merge provider traits are object-safe and heterogeneous;
2. all parser selection goes through TreeHaver `ParseService`;
3. workflow providers depend on parser capabilities, not parser packages;
4. normalized values and native extensions coexist without native objects in
   portable payloads;
5. in-process and host modes implement the same semantic traits;
6. Ruby-native workflows may execute the Ruby ast-merge/TreeHaver stack behind
   one coarse workflow callback;
7. Rust workflows may use a host parser only through Rust TreeHaver;
8. host callbacks are batched and runtime-affine;
9. rendering and edits consume existing plans and never re-decide semantics;
10. missing providers, capabilities, extensions, or preservation proof fail
    closed without hidden substitution.

## Non-goals

- implementing these traits in the current slice;
- preserving current non-Ruby implementation behavior as authority;
- choosing the final Alef wire codec or ABI;
- exporting per-node parser callbacks;
- requiring native parsers to become Rust libraries;
- allowing the Rust CLI to imply unavailable host providers.
