# Slice 834: Kettle Jem Appraisal Sub Dependencies

## Goal

Port deterministic sub-dependency resolution for Kettle/Jem appraisal matrix
generation using supplied dependency metadata.

## Contract

Given supplied parent-gem version metadata and supplied dependency version
metadata, active `kettle-jem` resolves runtime sub-dependencies by:

- selecting the latest patch for the requested parent minor version;
- reading its runtime dependency requirements;
- excluding supplied x-stdlib managed gems;
- selecting the newest dependency version satisfying both the parent
  requirement and the target Ruby floor;
- falling back to the oldest requirement-compatible version when no version is
  compatible with the Ruby floor.

No RubyGems API access is part of this slice.
