# Slice 977: Ruby Source Region Analysis

## Goal

Seed the Ruby-first source-region contract with an owner/interstitial fixture.

## Contract

Ruby source analysis MUST be able to report ordered source regions that include
both structural owners and interstitial content.

For this slice:

1. top-level `require` statements are source-owner regions,
2. top-level class declarations are source-owner regions,
3. blank lines between top-level owners are interstitial regions,
4. leading documentation comments immediately attached to a class belong to the
   class owner region,
5. method declarations inside a class may be reported as child owner regions,
6. leading documentation comments immediately attached to a method belong to the
   method owner region,
7. class wrapper text that is not part of a child owner remains a child
   interstitial region.

This slice does not require a particular Ruby parser. It standardizes the
observable region report shape that Ruby can prove first and other runtimes can
later match through their source-family implementations.

## Fixture

`fixtures/ruby/slice-977-source-region-analysis/class-method-source-regions.json`

## Notes

- This is the first bridge from Ruby's existing comment/layout/source-shaping
  substrate toward the Weave-style owner/interstitial region model.
- The fixture deliberately includes attached comments and blank-line gaps
  because reconstruction quality depends on both.
