`ruby-merge` MUST provide reviewed nested-merge entrypoints that consume:

- parent template Ruby source,
- parent destination Ruby source,
- Ruby dialect,
- and either:
  - one replay bundle carrying a reviewed nested execution payload for `ruby`,
    or
  - one review state carrying a reviewed nested execution payload for `ruby`.

The entrypoints MUST:

1. select the reviewed nested execution payload for `ruby`
2. execute that payload through the shared reviewed nested execution pipeline
3. return the same final reconstructed parent Ruby output as the equivalent
   direct reviewed nested merge inputs

Fixture:
- `yard-example-reviewed-nested-review-artifact-application.json`
