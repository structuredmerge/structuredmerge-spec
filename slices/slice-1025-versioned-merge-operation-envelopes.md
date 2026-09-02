# Slice 1025: Versioned Merge Operation Envelopes

## Status and scope

This slice defines the serialized form of Slice 1018's uniform merge-provider
contract. It does not create a second provider API. In-process providers and
FFI, process, CLI, and benchmark adapters use the same operation roles and
result semantics.

The contract identifiers are:

- `structuredmerge.operation-request/v1`;
- `https://structuredmerge.org/schemas/provider-result/v1.json`.

The result identifier intentionally matches the schema emitted by the Ruby
golden master's `Ast::Merge::ProviderResult`. This slice tightens its portable
transport rules without changing the meaning of the existing required fields.
Unknown major versions MUST be rejected. Compatible forwarders preserve
unknown fields and namespaced extensions.

Slice 1024 supplies source descriptors, parser selection reports, normalized
analysis, and byte-location rules. Slice 1019 supplies source render plans and
output provenance. Slice 1022 consumes these operations for portable
benchmarks but does not redefine their semantics.

## Selection layers

Every request keeps merge-provider selection and parser-backend requirements
separate.

`provider_selection` is consumed by the `ast-merge` provider registry and
contains:

- optional stable `provider_id`;
- required `family` when `provider_id` is absent;
- optional `dialect` and merge `profile_id`;
- required merge-provider capabilities.

`parser_selection` is passed by the selected merge provider to TreeHaver and
contains:

- optional explicit TreeHaver backend ID;
- ordered backend preference;
- required parser capabilities;
- optional parser profile or language version constraints.

A workflow merge provider MAY delegate to a backend-specific merge provider,
but the result reports both identities. It MUST NOT bypass TreeHaver to invoke
a parser. An explicit parser backend is never silently substituted. Policy
selection among compatible registered TreeHaver backends remains observable
through Slice 1024's selection report.

A backend-specific merge provider MAY require a corresponding TreeHaver
backend. A generic language substrate MUST NOT silently select an incompatible
native backend merely because that backend is registered. For example,
`ruby-merge` accepts Tree-sitter backends that satisfy its normalized contract;
`prism-merge` is a distinct backend provider requiring Prism behavior.

## Common request envelope

Every request contains:

- `schema`, equal to `structuredmerge.operation-request/v1`;
- globally unique `request_id`;
- `operation`: `analyze`, `diff2`, `merge2`, or `merge3`;
- `provider_selection` and `parser_selection`;
- `sources`, keyed by the exact semantic roles for the operation;
- optional `path_name`;
- operation-specific `policy`;
- `extensions` and `metadata`.

Each source is a Slice 1024 source descriptor. Its internal `role` MUST equal
the key under `sources`. Content may be inline or a verified local
content-addressed reference. An adapter MUST verify byte length and SHA-256
before dispatch.

Requests contain exactly the required semantic source roles:

| Operation | Required source roles |
| --- | --- |
| `analyze` | `source` |
| `diff2` | `before`, `after` |
| `merge2` | `incoming`, `current` |
| `merge3` | `base`, `ours`, `theirs` |

Adapters MUST NOT infer roles from argument order after normalization. They
MUST NOT add a synthetic base to `merge2`, drop the base from `merge3`, or map
template/destination onto ours/theirs.

The Ruby in-process API spells these values `source`, `before_source`,
`after_source`, `incoming_source`, `current_source`, `base_source`,
`ours_source`, and `theirs_source`. Transport normalization groups the same
roles under `sources`; it does not introduce different operation semantics.

## Operation policy

`analyze` policy may request analysis depth, comments, tokens, ownership, and
native extensions. It cannot request mutation.

`diff2` policy declares comparison profile, equivalence rules, and whether
source-preservation evidence is required. It does not render a merged source.

`merge2` policy declares the directional merge policy and render policy.
Incoming is policy/template-owned source; current is the existing destination.
Current-only content and retained current layout remain preservation concerns,
not optional formatter output.

`merge3` policy declares fallback policy, render policy, conflict marker size,
and labels. Base participates in classifying changes relative to ours and
theirs. A provider cannot implement `merge3` by invoking `merge2` or by
comparing only ours and theirs.

Fallback policy defaults to `none`. Any permitted semantic, parser, render, or
textual fallback is named in the request and recorded in the result. A provider
MUST NOT activate an undeclared fallback.

## Common result envelope

Every result contains the Slice 1018 fields:

- `schema`, equal to
  `https://structuredmerge.org/schemas/provider-result/v1.json`;
- `operation` and `ok`;
- `provider` and `profile`;
- ordered `diagnostics`, `changes`, `conflicts`, and `fallbacks`;
- `render_report` and `verification`.

Portable transports additionally require `request_id`, `extensions`, and
`metadata`. Existing in-process Ruby compatibility callers may omit
`request_id` until they cross a transport boundary; an adapter MUST add and
validate it before batching, FFI, process, CLI, or benchmark exchange.

The result operation MUST match the request operation. Provider identity
contains the selected workflow provider plus an ordered `delegation` chain
when delegation occurred. Parser selection belongs in `profile.parser`, not in
the merge-provider ID.

`ok` means the requested provider operation produced an accepted logical
result. It does not erase diagnostics or preservation evidence. Unsupported,
invalid, parse-failed, conflicted, render-failed, verification-failed, and
internal-failure outcomes are distinguished by structured diagnostics and
conflict records, not by parsing a message.

## Operation payloads

### Analyze

A successful `analyze` result contains `analysis` conforming to Slice 1024. It
has no `output` or `conflicted_output`. Parse failure identifies the failing
`source` role.

### Diff2

A successful `diff2` result contains `diff`, including stable change IDs,
before/after subject references, classifications, and source ranges when
known. It has no merged output. Verification records that both semantic roles
were consumed.

### Merge2

A clean `merge2` result contains String `output` and no
`conflicted_output`. Verification contains:

- `directional_roles_preserved: true`;
- consumed source roles `incoming` and `current`;
- output reparse and semantic verification;
- independent source-preservation evidence.

Conflicted directional merges contain conflict records and MAY contain
`conflicted_output` when the family can render coherent localized conflicts.
They MUST NOT report `ok: true`.

### Merge3

A clean `merge3` result contains String `output`, no `conflicted_output`, and
`verification.base_participated: true`. Verification also lists consumed
roles `base`, `ours`, and `theirs`.

An unresolved merge contains at least one conflict record and MAY contain
`conflicted_output`. If semantic classification was reached,
`base_participated` remains true even though `ok` is false. A parse or request
failure before classification may report false only with a blocking diagnostic
showing why classification was not reached. A semantic result with
`base_participated: false` is never valid.

## Changes and conflicts

Every change has a result-local stable ID, classification, subject reference
or structural path, per-role states, optional source spans, and metadata.
Change order is deterministic and MUST NOT depend on hash iteration or parser
object identity.

Every conflict has a result-local stable ID, category, subject reference or
structural path, the involved semantic roles, optional per-role exact source
regions, localization status, and resolution status. Full conflict and
diagnostic serialization is tightened by a later slice; this minimum shape is
required now so transport consumers never infer a conflict from marker text.

Conflict markers are rendering, not the conflict model. A result may report a
conflict without rendering marker text, particularly for binary or archive
families.

## Preservation and verification

Semantic correctness, source preservation, and reliability are independent.
`verification` contains:

- operation-specific role participation;
- output reparse and structural-equivalence status where applicable;
- required preservation properties and their pass/fail/unverified status;
- exact retained source regions and digests;
- synthesized regions and reasons;
- fallback verification.

A required preservation failure or unverified required property prevents a
clean successful result. Reformatting, comment loss, key reordering, line-ending
normalization, or blank-line churn cannot be hidden by a semantically equal
AST.

`render_report` references or embeds the Slice 1019 render plan, identifies its
producer, and records source, synthesized, and conflict fragment counts. It
does not duplicate semantic merge decisions.

## Diagnostics and failure behavior

Diagnostics follow Slice 1024's stable category, source role, severity,
blocking, span, and provider-code rules. At least one blocking diagnostic is
required when `ok` is false and no unresolved conflict exists.

An advertised operation returning unsupported is a provider conformance
failure. An unadvertised operation may return an explicit unsupported result.
No unsupported or failed operation may be replaced with another operation.

Results fail validation when they:

- omit or reverse semantic source roles;
- report a different operation;
- claim successful `merge3` without using base;
- claim successful `merge2` without preserving directional roles;
- contain both `output` and `conflicted_output`;
- report `ok: true` with unresolved conflicts;
- activate an undeclared fallback;
- claim successful output with failed required preservation;
- identify conflicts only through rendered marker text.

## Batch and Alef transport

A batch is an ordered list of complete requests. Results are returned in
request order or carry enough request IDs to restore that order. One request's
selection, parse state, diagnostics, extensions, or failure cannot leak into
another request.

Alef-generated bindings use the same coarse operation envelopes. Native hosts
may retain parser objects between calls, but process-local handles appear only
in explicitly negotiated extensions and never replace portable source,
selection, analysis, or verification evidence.

Cancellation and deadlines are transport controls. A cancelled or timed-out
request returns a reliability diagnostic and no fabricated merge result.

## Conformance

Conformance MUST prove:

1. all four operations accept only their exact semantic roles;
2. source role, byte length, and digest are verified before dispatch;
3. provider and parser selection remain separate and observable;
4. `analyze` and `diff2` never emit merged output;
5. `merge2` cannot reverse incoming/current or masquerade as `merge3`;
6. every classified `merge3` outcome proves base participation;
7. parse failure identifies the exact failing revision;
8. clean output and conflicted output are mutually exclusive;
9. conflicts are structured independently of rendered markers;
10. undeclared fallbacks and incompatible provider/backend combinations fail;
11. required preservation is a hard success condition;
12. unknown compatible extensions survive request/result forwarding;
13. batch execution preserves request identity and deterministic order.

## Non-goals

- defining family merge semantics;
- introducing another provider registry;
- selecting parsers outside TreeHaver;
- making `merge2` a degenerate `merge3` or vice versa;
- requiring every family to render textual conflict markers;
- defining the final stable conflict taxonomy in this slice.
