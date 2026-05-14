# Slice 719: Compact ruleset parser and recipe boundary

## Problem

The informational draft defines a compact line-oriented ruleset syntax, but the
implementation fixture corpus historically exercised JSON fixture structures
directly. Those JSON structures are useful transport and test fixtures, but they
are not the canonical ruleset syntax described by the draft.

## Contract

Each core `ast-merge` implementation should parse compact ruleset files that use
the syntax described in `MERGE_RULESET_INFORMATIONAL_DRAFT_02.md`, Appendix A.

The initial parser contract is intentionally small:

- ignore blank lines,
- preserve comment lines,
- parse directive lines as a directive name plus one or more arguments,
- validate directive and argument token shapes,
- require `format`, `owners`, `match`, `read`, and `attach`,
- reject repeated singleton directives,
- reject repeated keyed repeatable directives,
- validate the closed `read` vocabulary,
- validate the closed `attach` vocabulary.

## Fixture binding

The shared fixture repo now mirrors merge-output fixtures with compact ruleset
files:

```text
fixtures/json/slice-09-merge/object-merge.json
fixtures/rulesets/json/slice-09-merge/object-merge.smrules
```

Implementations should parse every `.smrules` fixture and reject malformed edge
cases.

## Recipe boundary findings

The current compact ruleset can describe these recipe-adjacent surfaces:

- document family via `format`,
- owner selection via `owners`,
- owner correspondence via `match`,
- comment/read realization class via `read`,
- non-structural attachment behavior via `attach`,
- comment syntax family via `comment_style`,
- output shaping family via `render`,
- optional semantic surfaces or boundaries via `capability`,
- logical-owner preservation classes via `logical_owner`,
- repair policies via `repair`,
- embedded/nested merge surfaces via `surface`,
- delegated merge policy via `delegate`.

The current compact syntax does **not** yet canonically describe all recipe
execution details found in JSON fixtures and package-template content recipes:

- concrete input payload fields such as `template`, `destination`, or
  `expected.output`,
- runtime facts and token replacement maps,
- provider/backend selection details beyond profile-level declarations,
- ordered multi-step recipe execution,
- concrete selectors with structured payloads,
- managed block marker text,
- transport envelopes and report shapes,
- review-state persistence payloads.

Those gaps are expected: the ruleset describes merge semantics; JSON fixtures
still carry test inputs, expected outputs, and transport examples. Future slices
should decide which recipe concepts deserve compact syntax directives and which
should remain JSON fixture/transport concerns.

## Validation

Initial parser parity was added to Go, Rust, TypeScript, and Ruby. All four
implementations parse the shared `.smrules` corpus and reject malformed edge
cases. Go parser tests can run as file-scoped tests without the local
tree-sitter language-pack static library; full Go package tests still require
that native library.
