`markdown-merge` MUST reject reviewed nested review artifact envelopes whose
transport identity does not match the expected review artifact kind or version.

The entrypoints that consume replay-bundle envelopes and review-state envelopes
MUST:

1. reject envelopes whose `kind` does not match the expected review artifact
2. reject envelopes whose `version` is unsupported
3. return `ok: false`
4. emit one diagnostic whose category and message match the shared transport
   import rejection

Fixture:
- `fenced-code-reviewed-nested-review-artifact-envelope-rejection.json`
