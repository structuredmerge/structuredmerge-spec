# Slice 207: Markdown Provider Manifest Report

## Goal

Allow native Markdown provider packages to produce manifest-wide reports for the
shared Markdown family suites.

## Shared Behavior

This slice defines one provider reporting contract:

1. a native Markdown provider MAY execute the shared Markdown suite manifest,
2. provider-backed suite reports keep the same Markdown family identity and
   case refs,
3. provider identity remains visible through the planned run contexts rather
   than changing the report envelope shape.
