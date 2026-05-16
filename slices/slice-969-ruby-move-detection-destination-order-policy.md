# Slice 969: Ruby Move Detection Destination Order Policy

Use Ruby move-detection evidence conservatively during merge planning.

## Contract

1. the default Ruby method move policy is `destination_order`
2. moved existing destination methods are treated as matched methods, not
   template-only insertions
3. destination method order is preserved by default
4. successful Ruby merge results expose the active method move policy in
   `merge_planning`
5. future recipe/per-file overrides may select a different policy, but the
   default must remain deterministic and non-interactive

## Fixture

`fixtures/ruby/slice-969-move-detection-destination-order-policy/move-detection-destination-order-policy.json`
