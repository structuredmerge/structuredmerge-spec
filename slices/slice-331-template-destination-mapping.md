## Slice 331: Template Destination Mapping

`ast-merge` MUST provide a shared helper that maps a logical
destination-relative template path to the actual destination-relative path that
the template runner should target.

Given a logical destination path and optional project context, the mapper MUST:

1. omit template-internal control files such as `.kettle-jem.yml`
2. map `.env.local` to `.env.local.example`
3. map `gem.gemspec` to `<project_name>.gemspec` when a project name is
   supplied
4. otherwise preserve the logical destination path unchanged

This slice defines destination remapping only. It does not walk directories,
read the filesystem, or choose templating strategies.
