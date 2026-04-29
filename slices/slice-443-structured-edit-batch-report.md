# Slice 443: Structured Edit Batch Report

## Goal

Expose a portable batch report contract for multiple CRISPR-style
structured-edit executions.

## Shared Behavior

This slice defines one shared batch-report contract:

1. a batch report carries one or more structured-edit execution `reports`,
2. report ordering remains visible,
3. shared diagnostics may remain visible at the batch level without changing
   per-report shape.

## Notes

- This slice standardizes orchestration output after the single-execution
  report surface exists.
