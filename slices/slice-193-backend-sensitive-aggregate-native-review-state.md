# Slice 193: Backend-Sensitive Aggregate Native Review State

## Goal

Prove that aggregate review-state generation remains stable when source-language
families are bound to their native-parser contexts.

## Contract

1. aggregate review-state generation preserves the same suite ordering as the
   backend-sensitive native aggregate report
2. source-language family contexts keep their native feature profiles
3. diagnostics, requests, and replay context are generated from the same
   aggregate inputs used by the backend-sensitive native report
