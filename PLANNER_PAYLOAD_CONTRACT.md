# Planner Payload Contract

`structuredmerge.planner_payload.v1` is the bridge shape for AI planners and
other orchestration systems. It describes a completed or in-progress
StructuredMerge job, the review evidence available for that job, and the safe
follow-up actions the planner may request.

This contract should be stabilized before binding the product to MCP tools.

## Top-Level Shape

```json
{
  "schema": "structuredmerge.planner_payload.v1",
  "job": {},
  "actions": [],
  "artifacts": [],
  "review_envelope": null,
  "review_decisions": [],
  "result_summary": null
}
```

Fields:

- `schema`: literal contract identifier.
- `job`: compact job summary with identity, account, operation, status, hashes,
  and timestamps.
- `actions`: safe next actions the planner may request.
- `artifacts`: available account-scoped artifacts for the job.
- `review_envelope`: signed or unsigned review evidence when the result requires
  review.
- `review_decisions`: account-scoped human decisions already recorded for the
  job.
- `result_summary`: compact result facts useful for planning without sending the
  full result body.

## Actions

The initial action vocabulary is:

| Action | Method | Meaning |
| --- | --- | --- |
| `parse` | `GET` | Fetch parsed result context without full event/artifact history. |
| `preview` | `GET` | Fetch compact preview context for review or planning. |
| `apply` | `POST` | Submit a follow-up StructuredMerge job. |
| `diff` | `POST` | Submit a diff job for before/after comparison. |

`apply` in this contract means patch-producing or artifact-producing apply. It
must not imply silent repository mutation unless a later policy-gated contract
explicitly allows that behavior.

## Review Decisions

Review decisions use this minimal shape:

```json
{
  "decision_id": "uuid",
  "job_id": "uuid",
  "account_id": "account",
  "actor_token_id": "sha256:...",
  "decision": "needs_changes",
  "comment": "optional human text",
  "created_at": "RFC3339-like timestamp"
}
```

Allowed `decision` values:

- `approved`
- `rejected`
- `needs_changes`

The planner must treat review decisions as account-scoped evidence. It should
not apply decisions from another account or from an unauthenticated context.

## Result Summary

`result_summary` should include only small, planner-relevant facts:

- `outcome`
- `format`
- `conflict_count`
- `diagnostic_count`
- `chunk_count`
- `metrics`
- `valid`

Large parse trees, full chunks, full JSONL exports, and binary artifacts belong
in artifacts or dedicated detail endpoints, not in the planner payload.

## MCP Implications

The first MCP server should expose this payload before inventing a separate MCP
schema. MCP tools can map onto the action vocabulary, but the planner payload
remains the shared review and orchestration context.
