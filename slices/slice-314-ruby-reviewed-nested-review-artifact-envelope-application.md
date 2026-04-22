`ruby-merge` MUST provide reviewed nested-merge entrypoints that consume:

- parent template Ruby source,
- parent destination Ruby source,
- Ruby dialect,
- and either:
  - one replay-bundle transport envelope carrying a replay bundle whose
    reviewed nested executions include `ruby`, or
  - one review-state transport envelope carrying a review state whose reviewed
    nested executions include `ruby`.

The entrypoints MUST:

1. import the review artifact transport envelope
2. select the reviewed nested execution payload for `ruby`
3. execute that payload through the shared reviewed nested execution pipeline
4. return the same final reconstructed parent Ruby output as the equivalent
   direct reviewed nested merge inputs

Fixture:
- `yard-example-reviewed-nested-review-artifact-envelope-application.json`
