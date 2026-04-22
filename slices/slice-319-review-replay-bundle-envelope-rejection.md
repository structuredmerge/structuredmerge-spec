## Slice 319: Review Replay Bundle Envelope Rejection

Reject replay-bundle transport envelopes whose identity does not match the
expected replay-bundle kind or version while still producing current manifest
review state.

Goals:
- surface envelope import failures as review diagnostics
- continue reviewing the current manifest without replay input
- preserve the current replay context and host hints

This slice defines one rejection contract:

1. importing replay-bundle envelope input requires kind `review_replay_bundle`
2. importing replay-bundle envelope input requires supported version `1`
3. when import fails, conformance review still runs without replay input
4. one transport diagnostic is added to the resulting review state

Fixture:
- `review-replay-bundle-envelope-rejection.json`
