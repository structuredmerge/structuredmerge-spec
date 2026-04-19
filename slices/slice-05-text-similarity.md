# Slice 05: Text Similarity

## Goal

Introduce the first behavior that starts to resemble document matching rather
than only parsing and result contracts.

## Planned Scope

- normalized block comparison
- thresholded similarity scoring
- shared fixture expectations for near-match cases

## Shared Behavior

This slice defines a small, portable similarity contract built on slice-03 text
analysis:

1. analyze both documents into normalized blocks
2. compare blocks by position
3. score each aligned block using Jaccard similarity over whitespace-delimited
   tokens
4. treat missing blocks as a score of `0.0`
5. overall similarity is the arithmetic mean across the larger block count

## Shared Types

- `TextSimilarity`
- `similarity_score` or equivalent host-language function
- `is_similar` or equivalent host-language function

## Threshold Guidance

- exact or normalization-equivalent matches should score `1.0`
- clearly unrelated documents should score near `0.0`
- threshold decisions remain caller-owned

## Intended Outputs

- minimal text similarity API in all three language families
- feedback on whether the DRAFT is behavior-oriented enough
- the first portable near-match contract that can inform future same-document
  verification work
