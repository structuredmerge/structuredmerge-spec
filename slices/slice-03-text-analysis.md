# Slice 03: Text Analysis

## Goal

Add the first real analysis contract for plain text documents.

## Planned Scope

- normalized text document wrapper
- block or paragraph segmentation
- text span representation
- fixture cases for whitespace normalization boundaries

## Shared Behavior

This slice defines one intentionally small normalization and segmentation rule:

1. normalize newlines to `\n`
2. trim leading and trailing document whitespace
3. split blocks on one or more blank lines
4. collapse internal whitespace inside each block to single spaces

This is not the final text model. It is the first portable baseline that all
language implementations should be able to reproduce.

## Shared Types

- `TextSpan`
- `TextBlock`
- `TextAnalysis`
- `analyze_text` or equivalent host-language function

## Intended Outputs

- portable text analysis type in all three language families
- first real fixture-driven behavior beyond placeholder contracts
- deterministic block analysis from identical input in all languages
