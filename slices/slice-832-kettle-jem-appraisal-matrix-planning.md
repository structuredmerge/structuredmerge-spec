# Slice 832: Kettle Jem Appraisal Matrix Planning

## Goal

Port deterministic appraisal matrix planning from supplied metadata into active
Ruby `kettle-jem`.

## Contract

The active helper surface can:

- select dependency versions from supplied version metadata using `major`,
  `minor`, `patch`, `minor-minmax`, or `semver` modes;
- apply optional Gem requirement filters without network access;
- build matrix entries from supplied tier-1 bucket assignments and optional
  tier-2 versions;
- derive appraisal names and modular gemfile paths through the rendering helper
  contract from slice 831.

This slice does not detect Ruby series seams, query RubyGems, or resolve
secondary dependencies. Those remain separate fixture slices.
