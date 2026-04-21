# frozen_string_literal: true

require "spec_helper"

# Regression tests for registration-driven Citrus fallback when tree-sitter
# backends are unavailable.
RSpec.describe "Citrus fallback", :citrus_backend do
  before do
    TreeHaver::LanguageRegistry.clear_cache!
    TreeHaver.register_language(:toml, grammar_module: TomlRB::Document, gem_name: "toml-rb") if defined?(TomlRB::Document)
  end

  after do
    TreeHaver::LanguageRegistry.clear_cache!
    TreeHaver.reset_backend!(to: :auto)
  end

  describe "registered Citrus grammar" do
    it "is registered for :toml in the test environment" do
      registration = TreeHaver.registered_language(:toml)
      expect(registration).to include(:citrus)
      expect(registration[:citrus]).to include(gem_name: "toml-rb")
    end
  end

  describe "TreeHaver.parser_for with Citrus fallback" do
    context "when tree-sitter backends are unavailable (simulating TruffleRuby)", :toml_rb do
      before do
        # Stub all native tree-sitter backends as unavailable
        # This simulates the TruffleRuby environment where native extensions don't work
        allow(TreeHaver::Backends::MRI).to receive(:available?).and_return(false)
        allow(TreeHaver::Backends::Rust).to receive(:available?).and_return(false)
        allow(TreeHaver::Backends::FFI).to receive(:available?).and_return(false)
        allow(TreeHaver::Backends::Java).to receive(:available?).and_return(false)

        # Stub GrammarFinder to return unavailable (no tree-sitter grammar found)
        # rubocop:disable RSpec/AnyInstance
        allow_any_instance_of(TreeHaver::GrammarFinder).to receive(:available?).and_return(false)
        # rubocop:enable RSpec/AnyInstance
      end

      context "with :toml (registered Citrus grammar)" do
        it "successfully creates a parser using Citrus backend" do
          parser = TreeHaver.parser_for(:toml)
          expect(parser).to be_a(TreeHaver::Parser)
          expect(parser.backend).to eq(:citrus)
        end

        it "can parse TOML content" do
          parser = TreeHaver.parser_for(:toml)
          tree = parser.parse('key = "value"')
          expect(tree).not_to be_nil
          expect(tree.root_node).not_to be_nil
        end

        it "does not require explicit citrus_config when grammar is registered" do
          expect {
            TreeHaver.parser_for(:toml)
          }.not_to raise_error
        end
      end

      context "with unknown language (no registered Citrus grammar)" do
        it "raises NotAvailable" do
          expect {
            TreeHaver.parser_for(:totally_unknown_language_xyz)
          }.to raise_error(TreeHaver::NotAvailable, /No parser available/)
        end
      end

      context "when explicit citrus_config is provided" do
        it "uses the explicit config instead of defaults" do
          custom_config = {
            gem_name: "toml-rb",
            grammar_const: "TomlRB::Document",
            require_path: "toml-rb",
          }

          parser = TreeHaver.parser_for(:toml, citrus_config: custom_config)
          expect(parser).to be_a(TreeHaver::Parser)
          expect(parser.backend).to eq(:citrus)
        end
      end
    end

    context "when tree-sitter is available but citrus_config with nil values is passed" do
      # This tests that we don't try to create CitrusGrammarFinder with nil values
      # which would cause TypeError from require(nil)
      it "does not raise TypeError when citrus_config has nil gem_name" do
        # This should either succeed with tree-sitter or raise NotAvailable
        # but NOT raise TypeError about nil conversion
        error = nil
        begin
          TreeHaver.parser_for(:toml, citrus_config: {gem_name: nil, grammar_const: nil})
        rescue Exception => e  # rubocop:disable Lint/RescueException
          # Must rescue Exception because NotAvailable inherits from Exception, not StandardError
          error = e
        end

        # TypeError would indicate the bug we're testing for
        expect(error).not_to be_a(TypeError)
        # NotAvailable is acceptable (means tree-sitter-toml not installed)
        expect(error).to be_nil.or be_a(TreeHaver::NotAvailable)
      end
    end
  end

  describe "TreeHaver::CitrusGrammarFinder" do
    describe "#initialize" do
      it "sets require_path from gem_name when require_path is nil" do
        finder = TreeHaver::CitrusGrammarFinder.new(
          language: :toml,
          gem_name: "toml-rb",
          grammar_const: "TomlRB::Document",
        )
        expect(finder.require_path).to eq("toml-rb")
      end

      it "uses explicit require_path when provided" do
        finder = TreeHaver::CitrusGrammarFinder.new(
          language: :toml,
          gem_name: "toml-rb",
          grammar_const: "TomlRB::Document",
          require_path: "custom/path",
        )
        expect(finder.require_path).to eq("custom/path")
      end
    end

    describe "#available?" do
      context "when gem_name is nil" do
        it "returns false without raising TypeError" do
          finder = TreeHaver::CitrusGrammarFinder.new(
            language: :test,
            gem_name: nil,
            grammar_const: "Test::Grammar",
          )
          # This should not raise TypeError, just return false
          expect(finder.available?).to be false
        end
      end

      context "when require_path is explicitly set to nil" do
        it "returns false without raising TypeError" do
          finder = TreeHaver::CitrusGrammarFinder.new(
            language: :test,
            gem_name: nil,
            grammar_const: "Test::Grammar",
            require_path: nil,
          )
          # This should not raise TypeError, just return false
          expect(finder.available?).to be false
        end
      end

      context "with valid toml-rb configuration", :toml_rb do
        it "returns true" do
          finder = TreeHaver::CitrusGrammarFinder.new(
            language: :toml,
            gem_name: "toml-rb",
            grammar_const: "TomlRB::Document",
            require_path: "toml-rb",
          )
          expect(finder.available?).to be true
        end
      end
    end
  end

  describe "Explicit Citrus backend usage on MRI", :toml_rb do
    # This test explicitly uses Citrus backend even on MRI where tree-sitter works
    # This ensures we test the Citrus code path regardless of native backend availability
    it "can use Citrus backend explicitly via with_backend" do
      TreeHaver.with_backend(:citrus) do
        parser = TreeHaver::Parser.new
        citrus_lang = TreeHaver::Backends::Citrus::Language.new(TomlRB::Document)
        parser.language = citrus_lang

        tree = parser.parse('key = "value"')
        expect(tree).not_to be_nil
        expect(tree.root_node).not_to be_nil
      end
    end

    it "can parse complex TOML via Citrus backend" do
      TreeHaver.with_backend(:citrus) do
        parser = TreeHaver::Parser.new
        citrus_lang = TreeHaver::Backends::Citrus::Language.new(TomlRB::Document)
        parser.language = citrus_lang

        toml_content = <<~TOML
          [package]
          name = "my-app"
          version = "1.0.0"

          [dependencies]
          foo = "1.0"
        TOML

        tree = parser.parse(toml_content)
        expect(tree).not_to be_nil
        expect(tree.root_node).not_to be_nil
      end
    end
  end
end
