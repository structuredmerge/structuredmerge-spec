# CLI Artifact and Provider Availability Policy

## Status and scope

This slice defines what a StructuredMerge CLI artifact may claim and execute.
It composes the provider traits from Slice 1030, the host lifecycle from Slice
1031, TreeHaver parser selection, and the stable diagnostics from Slice 1028.
It does not make the current private CLI provider-aware or choose a distribution
format.

The current `cli/` MVP directly implements JSON and text operations. The Rust
workspace CLI directly links a limited set of merge crates. Neither is evidence
that the future CLI can execute every provider described by the project. Product
and help output MUST be derived from the artifact manifest and runtime
availability report, not repository contents or package names.

## Artifact profiles

Every distributable artifact declares exactly one profile.

### Standalone

A standalone artifact contains the Rust kernel and only the in-process providers
listed in its signed artifact manifest. It may execute those providers without a
host runtime. Compiling host bridge support does not make any host provider
available.

Tree-sitter grammars may be linked, bundled as verified assets, or installed
through an explicit grammar-management operation. A merge operation MUST NOT
silently download a grammar. A cold or missing grammar cache is unavailable,
not permission to use a non-TreeHaver parser or a line merge.

### Embedded host

An embedded-host artifact is loaded by a named host package/runtime. The host
registers parser and workflow providers through the Slice 1031 bridge before
selection. The artifact manifest advertises bridge compatibility; the runtime
availability report records which registrations passed descriptor, contract,
and health validation in this process.

Installing a host package is not proof that it loaded successfully. Package
detection, constant detection, and filesystem probing MUST NOT bypass provider
registration.

### Explicit sidecar

A sidecar artifact connects only when invocation or trusted configuration names
an endpoint, expected host identity, protocol range, and authentication policy.
It never auto-discovers or silently starts a runtime. The sidecar handshake and
provider registrations follow Slice 1031, including schema negotiation,
runtime-affine ownership, limits, and health.

Local sockets or pipes are preferred. A network endpoint requires authenticated
transport and explicit policy. Sidecar loss makes its providers unavailable; it
does not trigger substitution.

## Build-time artifact manifest

The immutable manifest identifies:

- artifact ID, version, build revision, digest, target, and profile;
- supported kernel, operation, provider, diagnostic, and preservation schemas;
- built-in provider descriptors and their build-time asset requirements;
- supported host bridge protocols, without claiming host availability;
- linked, bundled, or externally managed grammar assets and their digests;
- grammar installation and network policy;
- compiled features and platform requirements;
- software bill of materials and signature references when published.

An artifact cannot advertise a provider omitted from this manifest. A bridge
protocol entry is a compatibility claim, not a provider descriptor. Generated
release notes, capability tables, and machine-readable help MUST preserve that
distinction.

## Runtime availability report

Before selection, the kernel builds an immutable report from the artifact
manifest and a bounded probe through each provider's intended interface. For
TSLP, probing or loading an on-demand grammar MUST use TSLP's public acquisition
path so cold-start behavior and its cache remain correct.

Each report records:

- artifact identity and verified digest;
- runtime profile and platform;
- registry generation and digest;
- parser and workflow provider stable IDs, kinds, origins, and contracts;
- availability state and stable reason code;
- asset source and verification state;
- host or sidecar registration generation when applicable;
- probe time and freshness policy;
- whether operation-time network access is permitted, which defaults to false.

The only selectable state is `available`. `compiled`, `manifest_only`,
`unregistered`, `unhealthy`, `asset_missing`, `incompatible`, and `retired` are
observable states but are not selectable.

### Loaded asset identity

Verified asset state MUST describe the bytes associated with the parser's actual
loaded handle, not merely a currently matching file at a configured pathname.
Cached libraries can outlive file replacement, removal, registry destruction,
and search-path changes. Evidence follows the retained loaded object across
those events; it MUST NOT be reconstructed by rehashing the current pathname.

The parser's intended loading interface owns this evidence. If it cannot expose
a trustworthy binding between verified bytes and the loaded object, that asset
identity remains unverified. A successful availability probe, grammar ABI,
language name, or package version MUST NOT substitute for it. Static grammars
require build-attested linked identity rather than a fabricated library path.
Preflight pins the loaded identity and execution rejects mismatch or stale
evidence without parser substitution. This requirement does not authorize a
second parser loader or implicit acquisition in the CLI.

## Selection

Parser selection remains exclusively in TreeHaver. The kernel passes language,
required parser capabilities, optional explicit provider stable ID, operation
requirements, and the availability snapshot to TreeHaver's normal selection
API. It does not reproduce backend preference in the CLI or a merge gem.

Workflow-provider selection is a separate step over `MergeProvider`
descriptors. A parser backend and a merge provider are not interchangeable even
when their package names or language labels match.

Selection is deterministic:

1. capture one parser and workflow registry generation;
2. filter to `available` providers whose contracts and capabilities satisfy all
   requirements;
3. honor an explicit stable ID exactly or fail closed;
4. apply declared policy priorities and stable tie breakers;
5. record the selected IDs, generations, profile, assets, and policy in the
   operation result.

Registration order, dependency load order, package discovery, and hash iteration
order are never tie breakers. A policy that requires Psych, Prism, native RBS,
or another host-native workflow fails when that provider is unavailable. It
does not silently use TSLP. Likewise, a requested TSLP provider never falls back
to a language-native parser, ad hoc parser, textual merge, or JSON/YAML library.

## Introspection and preflight

Every provider-aware CLI exposes machine-readable equivalents of:

- artifact inspection;
- provider listing with parser/workflow distinction;
- provider inspection with descriptor and availability evidence;
- operation preflight using the same selection path as execution;
- runtime health and grammar-asset status.

Command spelling is not fixed by this slice. Human-readable output is a view of
the same report. Preflight may install or warm grammar assets only when the user
explicitly invokes an installation/preparation action allowed by policy. A
normal merge, template, diff, or verify command is side-effect free with respect
to provider installation and network acquisition.

Preflight success pins the manifest digest, registry generations, provider IDs,
asset digests, and policy digest into the operation request. Execution rejects
stale or changed evidence rather than selecting again under different state.

## Diagnostics and exits

Availability and selection failures use Slice 1028 diagnostics. Stable codes
distinguish at least:

- artifact manifest or digest failure;
- unsupported artifact profile or platform;
- provider absent from artifact;
- host provider unregistered, unhealthy, retired, or incompatible;
- sidecar identity, authentication, protocol, or health failure;
- grammar asset missing, corrupt, or forbidden by network policy;
- no provider satisfies capabilities;
- explicit provider unavailable;
- ambiguous policy after stable filtering;
- stale preflight evidence.

No diagnostic fabricates merge output. Human error text, host exception text,
and transport details remain origin/debug evidence rather than stable codes.
Exit status categories are stable and machine documented, while detailed causes
remain in the result envelope.

## Packaging and release claims

Conformance is evaluated per artifact and profile, not per repository or product
family. A standalone build can be conformant for TSLP JSON while correctly
reporting Psych YAML unavailable. An embedded Ruby artifact can separately claim
Psych YAML after observed registration and conformance evidence.

Published capability claims MUST name the artifact digest or release, provider
stable ID, profile, target, contract versions, and evidence state. A source tree
containing 370 grammars, a compiled Alef bridge, or an installed Ruby gem is not
execution evidence.

## Conformance

The fixture MUST reject manifest/runtime conflation, implicit host startup,
undeclared network acquisition, package-name discovery, registration-order
selection, parser/workflow conflation, cold-cache fallback, stale preflight
execution, platform mismatch, sidecar identity mismatch, and any fallback away
from TreeHaver or the selected merge provider.

## Non-goals

- choosing final CLI command names or installation formats;
- implementing provider discovery in the current MVP CLIs;
- selecting the final Alef host codec or ABI;
- bundling Ruby or another host runtime into every standalone build;
- promising every TSLP grammar in every artifact;
- permitting direct parser calls outside TreeHaver;
- permitting merge logic outside the selected `MergeProvider`/ast-merge stack.
