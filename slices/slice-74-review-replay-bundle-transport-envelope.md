## Slice 74: Review Replay Bundle Transport Envelope

Wrap exported replay bundles in one explicit versioned transport envelope.

Goals:
- define one stable replay-bundle transport kind
- reuse the same baseline transport version
- keep the underlying replay-bundle payload unchanged

This slice defines one narrow contract:

1. exported replay bundles may be wrapped in an envelope
2. the envelope carries `kind`, `version`, and `replay_bundle`
3. the baseline replay-bundle transport kind is `review_replay_bundle`
4. the baseline review transport version is `1`

Fixture:
- `review-replay-bundle-envelope.json`
