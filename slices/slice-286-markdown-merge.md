## Slice 286: Markdown Merge

Define the baseline document-level merge for Markdown structural owners.

### Why

- Markdown family coverage currently stops at analysis, matching, and delegated
  child workflows
- the family needs one direct end-to-end merge contract with two source
  documents and one merged output

### Rules

1. matched structural sections prefer destination section text
2. unmatched destination structural sections are preserved in destination order
3. unmatched template structural sections are appended in template order
4. the baseline merge only covers heading and fenced-code-block structural
   owners plus the text enclosed by those owners

### Notes

- baseline rendering is normalized Markdown with a trailing newline
- tolerant Markdown parsing means malformed-input diagnostics are out of scope
- body-aware prose merge and formatter-aware rewrite remain out of scope
