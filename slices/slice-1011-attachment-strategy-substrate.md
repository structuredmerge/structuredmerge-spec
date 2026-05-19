# Slice 1011: Attachment-Strategy Substrate

`ast-merge` should keep recurring attachment orchestration behind named shared
strategies rather than per-gem method folklore.

The Ruby substrate already dispatches `layout_only`, `tracker_layout_merge`,
`augmenter_preferred_tracker_layout`, and `normalize_tracked_layout_merge`
through `FileAnalyzable#shared_comment_attachment_for`. Downstream analyses
select the behavior with `comment_attachment_strategy`; compact rulesets select
the same vocabulary through the `attach` directive.
