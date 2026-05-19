# Slice 991: Ruby File Edge Merge

Ruby should preserve destination-owned file-header and file-footer interstitial
content during source merge. Header content already flows through the preamble;
this slice adds explicit footer coverage.

