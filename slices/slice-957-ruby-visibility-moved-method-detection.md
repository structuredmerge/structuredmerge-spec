## Slice 957: Ruby Visibility Moved Method Detection

Treat a destination method with the same receiver-aware signature as the same
method even when it has moved to a different visibility section.

### Why

- moved-method detection should start with exact signature moves before broader
  fuzzy relocation
- visibility changes are common when a template evolves public/private layout
- merge must not duplicate a destination method solely because it appears under
  a different visibility marker than the template

### Rules

1. direct methods are matched by receiver-aware signature across visibility
   sections
2. destination-owned method location and visibility win
3. matched moved methods are not inserted again from the template
4. destination source text remains unchanged for the matched method
