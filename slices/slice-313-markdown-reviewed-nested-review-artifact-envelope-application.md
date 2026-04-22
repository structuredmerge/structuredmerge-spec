`markdown-merge` MUST provide reviewed nested-merge entrypoints that consume:

- parent template Markdown source,
- parent destination Markdown source,
- Markdown dialect,
- and either:
  - one replay-bundle transport envelope carrying a replay bundle whose
    reviewed nested executions include `markdown`, or
  - one review-state transport envelope carrying a review state whose reviewed
    nested executions include `markdown`.

The entrypoints MUST:

1. import the review artifact transport envelope
2. select the reviewed nested execution payload for `markdown`
3. execute that payload through the shared reviewed nested execution pipeline
4. return the same final reconstructed parent Markdown output as the equivalent
   direct reviewed nested merge inputs

Fixture:
- `fenced-code-reviewed-nested-review-artifact-envelope-application.json`
