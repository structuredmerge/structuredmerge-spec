# Slice 192: Backend-Sensitive Aggregate Tree-Sitter Review State

## Goal

Prove that aggregate review-state generation remains stable when source-language
families are bound to their tree-sitter-backed contexts.

## Contract

1. aggregate review-state generation preserves the same suite ordering as the
   backend-sensitive tree-sitter aggregate report
2. source-language family contexts keep their tree-sitter feature profiles
3. diagnostics, requests, and replay context are generated from the same
   aggregate inputs used by the backend-sensitive tree-sitter report
