# frozen_string_literal: true

# External gems
# These gems are attempted to be loaded by lib/tree_haver/rspec/dependency_tags.rb,
# so we can dynamically skip tests that depend on them. For the TreeHaver test
# suite we also register TOML grammars explicitly so parser_for exercises the
# same registration-driven flow expected from external merge gems.

begin
  require "tree_haver"
rescue LoadError
  nil
end

begin
  require "toml-rb"
  TreeHaver.register_language(:toml, grammar_module: TomlRB::Document, gem_name: "toml-rb") if defined?(TreeHaver) && defined?(TomlRB::Document)
rescue LoadError, NameError
  nil
end

begin
  require "toml"
  TreeHaver.register_language(:toml, grammar_class: TOML::Parslet, gem_name: "toml") if defined?(TreeHaver) && defined?(TOML::Parslet)
rescue LoadError, NameError
  nil
end

# Much of the config is loaded automatically by the .rspec config
# require_relative "spec_thin_helper"
