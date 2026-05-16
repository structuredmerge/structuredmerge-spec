# Slice 968: Ruby Merge Move Detection Report

Surface Ruby method move detection during normal Ruby merge planning.

## Contract

1. successful Ruby merge results include a `matching_reports` array
2. the Ruby method move-detection report uses the generic move-detection report
   shape from slice 961
3. moved methods are advisory at this stage; output ordering is not silently
   changed by the report
4. downstream tools can inspect the report to explain why existing destination
   methods were matched rather than reinserted

## Fixture

`fixtures/ruby/slice-968-merge-move-detection-report/merge-move-detection-report.json`
