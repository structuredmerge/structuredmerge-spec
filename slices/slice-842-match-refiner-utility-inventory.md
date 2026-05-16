# Slice 842: Match Refiner Utility Inventory

## Goal

Classify the old `ast-merge` match refiner helpers and format-specific fuzzy
matching implementations before porting any scoring algorithm into active merge
behavior.

## Contract

Fuzzy/refined matching is useful but must remain fixture-gated. Exact matching,
semantic classification, move-detection reports, and explicit provider
capabilities remain the default path.

The old generic ideas survive as future contracts:

- 1:1 greedy matching over unmatched candidates;
- match results with score and metadata;
- thresholded acceptance;
- token/Jaccard similarity;
- content/length/position weighted scoring;
- composite refiner pipelines that consume matched candidates before later
  passes run.

No old refiner should be copied into active behavior without a family fixture
that defines the acceptable match, diagnostics, threshold, and failure mode.
