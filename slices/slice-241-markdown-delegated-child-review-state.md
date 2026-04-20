# Slice 241: Markdown Delegated Child Group Review State

`markdown-merge` MUST use the shared delegated child group review-state helper
for apply-ready fenced-code child groups.

This proves that Markdown can keep unresolved fenced-code groups as requests,
accept replayed apply decisions for matching groups, and reject stale delegated
child decisions explicitly.
