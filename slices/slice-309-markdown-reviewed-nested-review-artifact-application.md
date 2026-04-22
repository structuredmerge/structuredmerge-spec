`markdown-merge` MUST provide reviewed nested-merge entrypoints that consume:

- parent template Markdown source,
- parent destination Markdown source,
- Markdown dialect,
- and either:
  - one replay bundle carrying a reviewed nested execution payload for
    `markdown`, or
  - one review state carrying a reviewed nested execution payload for
    `markdown`.

The entrypoints MUST:

1. select the reviewed nested execution payload for `markdown`
2. execute that payload through the shared reviewed nested execution pipeline
3. return the same final reconstructed parent Markdown output as the equivalent
   direct reviewed nested merge inputs

Fixture:
- `fenced-code-reviewed-nested-review-artifact-application.json`
