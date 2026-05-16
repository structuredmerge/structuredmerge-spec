# Slice 845: Comment, Layout, And Structural Edit Helper Inventory

## Goal

Classify the old Ruby `ast-merge` comment, layout, structural edit, navigable,
and text fallback helpers against the active StructuredMerge contracts.

## Contract

The portable surface is normalized metadata and execution/report behavior, not
the old helper class hierarchy.

Portable comment behavior:

- providers may project leading, inline, trailing, orphan, preamble, and
  postlude comment regions into node metadata or semantic sidecars;
- comment styles use normalized style identifiers such as hash comments, HTML
  comments, C-style line comments, and C-style block comments;
- freeze directives use the shared directive vocabulary from slice 843;
- compatible multi-line comment regions may be text-submerged only when the
  active profile and family fixtures allow it;
- inline comments default to preserve-preferred behavior unless a family fixture
  defines a safer merge.

Portable layout behavior:

- blank-line gaps are modeled as preamble, interstitial, or postlude gaps;
- each gap has adjacent owners and one output controller;
- interstitial gap control may fall back to the surviving adjacent owner when
  the original controller is removed;
- layout-sensitive rendering must report the chosen controller and fallback.

Portable structural edit behavior:

- exact line-range replacement preserves source outside the edited range;
- contiguous removal reports removed owners, retained boundaries, and promoted
  comment/layout fragments;
- rehome plans are passive transfer records from removed owners to surviving
  boundaries;
- batched edits must be non-overlapping and applied against one source version;
- selectors and injection points feed structured edit destination profiles
  rather than a standalone public navigable API.

Renderer ownership:

- shared fixtures define attachment, gap, rehome, fallback, and diagnostic
  shapes;
- family/provider renderers own syntax-aware whitespace, separator, indentation,
  comment-prefix, and reparsing details;
- a provider must not claim layout-sensitive preservation until fixtures verify
  render and reparse behavior for that family.

Retired shared API:

- old `Comment::*`, `Layout::*`, `StructuralEdit::*`, `Navigable::*`, and
  `Text::*` classes should not be copied as public portable API in this pass;
- their passive record shapes may be reintroduced as Ruby-local conveniences or
  shared internal helpers only when active fixtures require them.
