# frozen_string_literal: true

require "spec_helper"

RSpec.describe TreeHaver::Parser, :toml_parsing do
  before do
    TreeHaver.reset_backend!(to: :auto)
  end

  after do
    TreeHaver.reset_backend!(to: :auto)
  end

  # Helper to create a parser using auto-discovery (works on all platforms)
  def create_toml_parser
    TreeHaver.parser_for(:toml)
  end

  describe "#initialize" do
    context "when a backend is available" do
      it "creates a parser instance" do
        expect {
          described_class.new
        }.not_to raise_error
      end
    end

    context "when no backend is available" do
      before do
        allow(TreeHaver).to receive(:backend_module).and_return(nil)
      end

      it "raises NotAvailable" do
        expect {
          described_class.new
        }.to raise_error(TreeHaver::NotAvailable, /No TreeHaver backend/)
      end
    end

    context "when tree-sitter backend fails and Citrus fallback is available" do
      let(:failing_backend_module) do
        mod = Module.new
        parser_class = Class.new do
          define_method(:initialize) do
            raise LoadError, "Simulated tree-sitter load failure"
          end
        end
        mod.const_set(:Parser, parser_class)
        mod
      end

      before do
        allow(TreeHaver).to receive(:resolve_backend_module).and_return(failing_backend_module)
        allow(TreeHaver::Backends::Citrus).to receive(:available?).and_return(true)
      end

      it "falls back to Citrus when tree-sitter backend fails with LoadError" do
        parser = described_class.new
        expect(parser.backend).to eq(:citrus)
      end
    end

    context "when tree-sitter fails with NoMethodError and Citrus available" do
      let(:failing_backend_module) do
        mod = Module.new
        parser_class = Class.new do
          define_method(:initialize) do
            raise NoMethodError, "Simulated method error"
          end
        end
        mod.const_set(:Parser, parser_class)
        mod
      end

      before do
        allow(TreeHaver).to receive(:resolve_backend_module).and_return(failing_backend_module)
        allow(TreeHaver::Backends::Citrus).to receive(:available?).and_return(true)
      end

      it "falls back to Citrus when tree-sitter backend fails with NoMethodError" do
        parser = described_class.new
        expect(parser.backend).to eq(:citrus)
      end
    end

    context "when tree-sitter fails and Citrus is NOT available" do
      let(:failing_backend_module) do
        mod = Module.new
        parser_class = Class.new do
          define_method(:initialize) do
            raise LoadError, "Simulated tree-sitter load failure"
          end
        end
        mod.const_set(:Parser, parser_class)
        mod
      end

      before do
        allow(TreeHaver).to receive(:resolve_backend_module).and_return(failing_backend_module)
        allow(TreeHaver::Backends::Citrus).to receive(:available?).and_return(false)
        allow(TreeHaver::Backends::Parslet).to receive(:available?).and_return(false)
      end

      it "raises NotAvailable with helpful message" do
        expect {
          described_class.new
        }.to raise_error(TreeHaver::NotAvailable, /Tree-sitter backend failed.*fallback not available/)
      end
    end

    context "when tree-sitter fails and Parslet is available" do
      let(:failing_backend_module) do
        mod = Module.new
        parser_class = Class.new do
          def initialize
            raise LoadError, "Simulated tree-sitter load failure"
          end
        end
        mod.const_set(:Parser, parser_class)
        mod
      end

      it "falls back to Parslet when Citrus is unavailable" do
        fake_parslet_parser = Class.new { attr_accessor :language }.new

        allow(TreeHaver).to receive(:resolve_backend_module).and_return(failing_backend_module)
        allow(TreeHaver::Backends::Citrus).to receive(:available?).and_return(false)
        allow(TreeHaver::Backends::Parslet).to receive(:available?).and_return(true)
        allow(TreeHaver::Backends::Parslet::Parser).to receive(:new).and_return(fake_parslet_parser)

        parser = described_class.new
        expect(parser.backend).to eq(:parslet)
      end
    end

    context "when explicit backend requested and it fails" do
      let(:failing_backend_module) do
        mod = Module.new
        parser_class = Class.new do
          define_method(:initialize) do
            raise LoadError, "Backend specific failure"
          end
        end
        mod.const_set(:Parser, parser_class)
        mod
      end

      before do
        allow(TreeHaver).to receive(:resolve_backend_module).with(:failing_backend).and_return(failing_backend_module)
      end

      it "re-raises the error without fallback when explicit backend requested" do
        expect {
          described_class.new(backend: :failing_backend)
        }.to raise_error(LoadError, /Backend specific failure/)
      end
    end
  end

  describe "#language=" do
    it "sets the language on the backend parser" do
      parser = create_toml_parser
      # The parser_for already sets a language, so verify parsing works
      tree = parser.parse("key = \"value\"")
      expect(tree).to be_a(TreeHaver::Tree)
      expect(tree.root_node).not_to be_nil
    end

    it "switches to Citrus parser when language backend is Citrus" do
      stub_const("TreeHaver::Backends::Citrus::Parser", Class.new { attr_accessor :language })

      parser = described_class.allocate
      parser.instance_variable_set(:@impl, Class.new { attr_accessor :language }.new)
      parser.instance_variable_set(:@explicit_backend, :mri)

      language = double("lang", backend: :citrus)

      parser.language = language

      expect(parser.backend).to eq(:citrus)
      expect(parser.instance_variable_get(:@impl)).to be_a(TreeHaver::Backends::Citrus::Parser)
    end

    it "does not switch when already using Citrus parser" do
      citrus_impl = Class.new { attr_accessor :language }.new
      stub_const("TreeHaver::Backends::Citrus::Parser", Class.new)
      allow(TreeHaver::Backends::Citrus::Parser).to receive(:new).and_return(citrus_impl)

      parser = described_class.allocate
      parser.instance_variable_set(:@impl, citrus_impl)
      parser.instance_variable_set(:@explicit_backend, :citrus)

      language = double("lang", backend: :citrus)

      parser.language = language

      expect(TreeHaver::Backends::Citrus::Parser).not_to have_received(:new)
    end

    it "switches to Parslet parser when language backend is Parslet" do
      stub_const("TreeHaver::Backends::Parslet::Parser", Class.new { attr_accessor :language })

      parser = described_class.allocate
      parser.instance_variable_set(:@impl, Class.new { attr_accessor :language }.new)
      parser.instance_variable_set(:@explicit_backend, :mri)

      language = double("lang", backend: :parslet)

      parser.language = language

      expect(parser.backend).to eq(:parslet)
      expect(parser.instance_variable_get(:@impl)).to be_a(TreeHaver::Backends::Parslet::Parser)
    end

    it "does not switch when already using Parslet parser" do
      parslet_impl = Class.new { attr_accessor :language }.new
      stub_const("TreeHaver::Backends::Parslet::Parser", Class.new)
      allow(TreeHaver::Backends::Parslet::Parser).to receive(:new).and_return(parslet_impl)

      parser = described_class.allocate
      parser.instance_variable_set(:@impl, parslet_impl)
      parser.instance_variable_set(:@explicit_backend, :parslet)

      language = double("lang", backend: :parslet)

      parser.language = language

      expect(TreeHaver::Backends::Parslet::Parser).not_to have_received(:new)
    end

    it "switches to Prism parser when language backend is Prism" do
      stub_const("TreeHaver::Backends::Prism::Parser", Class.new { attr_accessor :language })

      parser = described_class.allocate
      parser.instance_variable_set(:@impl, Class.new { attr_accessor :language }.new)
      parser.instance_variable_set(:@explicit_backend, :mri)

      language = double("lang", backend: :prism)

      parser.language = language

      expect(parser.backend).to eq(:prism)
      expect(parser.instance_variable_get(:@impl)).to be_a(TreeHaver::Backends::Prism::Parser)
    end

    it "does not switch when already using Prism parser" do
      prism_impl = Class.new { attr_accessor :language }.new
      stub_const("TreeHaver::Backends::Prism::Parser", Class.new)
      allow(TreeHaver::Backends::Prism::Parser).to receive(:new).and_return(prism_impl)

      parser = described_class.allocate
      parser.instance_variable_set(:@impl, prism_impl)
      parser.instance_variable_set(:@explicit_backend, :prism)

      language = double("lang", backend: :prism)

      parser.language = language

      expect(TreeHaver::Backends::Prism::Parser).not_to have_received(:new)
    end

    it "switches to Psych parser when language backend is Psych" do
      stub_const("TreeHaver::Backends::Psych::Parser", Class.new { attr_accessor :language })

      parser = described_class.allocate
      parser.instance_variable_set(:@impl, Class.new { attr_accessor :language }.new)
      parser.instance_variable_set(:@explicit_backend, :mri)

      language = double("lang", backend: :psych)

      parser.language = language

      expect(parser.backend).to eq(:psych)
      expect(parser.instance_variable_get(:@impl)).to be_a(TreeHaver::Backends::Psych::Parser)
    end

    it "does not switch when already using Psych parser" do
      psych_impl = Class.new { attr_accessor :language }.new
      stub_const("TreeHaver::Backends::Psych::Parser", Class.new)
      allow(TreeHaver::Backends::Psych::Parser).to receive(:new).and_return(psych_impl)

      parser = described_class.allocate
      parser.instance_variable_set(:@impl, psych_impl)
      parser.instance_variable_set(:@explicit_backend, :psych)

      language = double("lang", backend: :psych)

      parser.language = language

      expect(TreeHaver::Backends::Psych::Parser).not_to have_received(:new)
    end
  end

  describe "#parse" do
    let(:parser) { create_toml_parser }

    it "parses source and returns a TreeHaver::Tree" do
      tree = parser.parse("key = \"value\"")
      expect(tree).to be_a(TreeHaver::Tree)
    end

    it "stores source in the tree" do
      source = "key = \"value\""
      tree = parser.parse(source)
      expect(tree).to respond_to(:source)
    end

    it "provides access to the root node" do
      tree = parser.parse("key = \"value\"")
      root = tree.root_node
      expect(root).to be_a(TreeHaver::Node)
    end
  end

  describe "#parse_string" do
    let(:parser) { create_toml_parser }
    let(:source) { "key = \"value\"" }

    context "with nil old_tree" do
      it "parses source and returns a TreeHaver::Tree" do
        tree = parser.parse_string(nil, source)
        expect(tree).to be_a(TreeHaver::Tree)
      end
    end

    context "with an old tree (incremental parsing)" do
      it "supports incremental parsing by extracting inner_tree from wrapper" do
        old_tree = parser.parse("key = \"old\"")
        expect(old_tree).to be_a(TreeHaver::Tree)

        # Falls back to regular parsing if backend doesn't support it
        new_tree = parser.parse_string(old_tree, "key = \"new\"")
        expect(new_tree).to be_a(TreeHaver::Tree)
      end
    end

    context "when backend doesn't support parse_string" do
      it "falls back to regular parse" do
        # This is hard to test without mocking internals
        # Just verify the method exists and can be called
        result = parser.parse_string(nil, source)
        expect(result).to be_a(TreeHaver::Tree)
      end
    end

    context "with old_tree that has instance variables fallback" do
      it "extracts tree from instance variable" do
        # This test requires mocking which doesn't work with real backends
        # Real backends validate the tree type strictly
        # Skip this test as the behavior is implementation-specific
        skip "Cannot test instance variable fallback with real backend - backend validates tree type"
      end
    end

    context "when backend supports parse_string but old_tree is nil" do
      it "passes nil to backend parse_string" do
        tree = parser.parse_string(nil, source)
        expect(tree).to be_a(TreeHaver::Tree)
      end
    end

    context "with old_tree parameter" do
      let(:old_tree_impl) { double("OldTreeImpl") }
      let(:new_tree_impl) { double("NewTreeImpl", root_node: double(type: "root", child_count: 0)) }
      let(:impl) { double("ParserImpl", parse_string: new_tree_impl, "language=": nil) }

      let(:fake_backend_module) do
        mod = Module.new
        impl_inst = impl
        parser_class = Class.new do
          define_method(:initialize) do
            @impl = impl_inst
          end
          attr_reader :impl
          define_method(:language=) { |lang| @impl.language = lang }
          define_method(:parse_string) { |old, src| @impl.parse_string(old, src) }
        end
        mod.const_set(:Parser, parser_class)
        mod
      end

      before do
        allow(TreeHaver).to receive(:resolve_backend_module).and_return(fake_backend_module)
      end

      it "extracts impl from Tree wrapper when old_tree has #inner_tree" do
        parser = described_class.new

        old_tree_wrapper = double("TreeWrapper")
        allow(old_tree_wrapper).to receive(:respond_to?).and_return(false)
        allow(old_tree_wrapper).to receive_messages(respond_to?: true, inner_tree: old_tree_impl)
        allow(old_tree_wrapper).to receive(:respond_to?).with(:inner_tree).and_return(true)

        allow(impl).to receive(:parse_string).with(old_tree_impl, "new source").and_return(new_tree_impl)

        result = parser.parse_string(old_tree_wrapper, "new source")
        expect(result).to be_a(TreeHaver::Tree)
      end

      it "extracts impl from legacy wrapper when old_tree has @impl" do
        parser = described_class.new

        old_tree_wrapper = double("TreeWrapper")
        allow(old_tree_wrapper).to receive(:respond_to?).and_return(true)
        allow(old_tree_wrapper).to receive(:respond_to?).with(:inner_tree).and_return(false)
        allow(old_tree_wrapper).to receive(:instance_variable_get).with(:@inner_tree).and_return(nil)
        allow(old_tree_wrapper).to receive(:instance_variable_get).with(:@impl).and_return(old_tree_impl)

        allow(impl).to receive(:parse_string).with(old_tree_impl, "new source").and_return(new_tree_impl)

        result = parser.parse_string(old_tree_wrapper, "new source")
        expect(result).to be_a(TreeHaver::Tree)
      end

      it "uses old_tree directly when it's not a wrapper" do
        parser = described_class.new

        allow(old_tree_impl).to receive(:respond_to?).and_return(false)

        allow(impl).to receive(:parse_string).with(old_tree_impl, "new source").and_return(new_tree_impl)

        result = parser.parse_string(old_tree_impl, "new source")
        expect(result).to be_a(TreeHaver::Tree)
      end
    end
  end

  describe "backend parameter" do
    # NOTE: Do NOT reset backends_used! The tracking is essential for backend_protect

    after do
      # Clean up thread-local state
      Thread.current[:tree_haver_backend_context] = nil
    end

    describe "Parser.new" do
      context "with no backend parameter", :citrus_backend do
        it "uses effective backend from context/global (non-conflicting)" do
          # Use citrus since it never conflicts
          TreeHaver.with_backend(:citrus) do
            parser = described_class.new
            expect(parser.backend).to eq(:citrus)
          end
        end

        it "uses global backend when no context set" do
          TreeHaver.backend = :auto
          parser = described_class.new
          # parser.backend returns the actual resolved backend, not :auto
          # It should be one of the available backends
          valid_backends = [:mri, :rust, :ffi, :java, :citrus]
          expect(valid_backends).to include(parser.backend)
        end
      end

      context "with explicit backend parameter" do
        it "uses specified backend regardless of context (non-conflicting)", :citrus_backend do
          TreeHaver.with_backend(:mri) do
            parser = described_class.new(backend: :citrus)
            expect(parser.backend).to eq(:citrus)
          end
        end

        it "overrides global backend setting (non-conflicting)", :citrus_backend do
          TreeHaver.backend = :mri
          parser = described_class.new(backend: :citrus)
          expect(parser.backend).to eq(:citrus)
        end

        it "creates parser with MRI backend when specified", :mri_backend do
          parser = described_class.new(backend: :mri)
          expect(parser.backend).to eq(:mri)
        end

        it "creates parser with FFI backend when specified", :ffi_backend do
          parser = described_class.new(backend: :ffi)
          expect(parser.backend).to eq(:ffi)
        end

        it "creates parser with Rust backend when specified", :rust_backend do
          parser = described_class.new(backend: :rust)
          expect(parser.backend).to eq(:rust)
        end

        it "creates parser with Citrus backend when specified", :citrus_backend do
          parser = described_class.new(backend: :citrus)
          expect(parser.backend).to eq(:citrus)
        end

        it "raises NotAvailable when requested backend is not available" do
          # Try to use a backend that definitely won't be available
          unavailable_backend = if defined?(RUBY_ENGINE) && RUBY_ENGINE == "jruby"
            :mri  # MRI backend won't work on JRuby
          else
            :java  # Java backend won't work on MRI
          end

          expect do
            described_class.new(backend: unavailable_backend)
          end.to raise_error(TreeHaver::NotAvailable, /Requested backend .* is not available/)
        end

        it "accepts string backend names", :mri_backend do
          parser = described_class.new(backend: "mri")
          expect(parser.backend).to eq(:mri)
        end
      end

      context "with backend introspection" do
        it "returns thread-local backend when no explicit backend set", :mri_backend do
          TreeHaver.with_backend(:mri) do
            parser = described_class.new
            expect(parser.backend).to eq(:mri)
          end
        end

        it "returns explicit backend when set", :mri_backend, :rust_backend do
          TreeHaver.with_backend(:mri) do
            parser = described_class.new(backend: :rust)
            expect(parser.backend).to eq(:rust)
          end
        end

        it "returns consistent backend throughout parser lifecycle", :mri_backend do
          parser = described_class.new(backend: :mri)

          # Change context after parser creation
          TreeHaver.with_backend(:rust) do
            # Parser should still report :mri
            expect(parser.backend).to eq(:mri)
          end
        end
      end
    end

    describe "Thread-safe parser creation", :citrus_backend, :rust_backend do
      it "creates parsers with different backends in concurrent threads" do
        # Use Rust and Citrus which can coexist (not FFI which conflicts with MRI)
        results = Concurrent::Array.new if defined?(Concurrent::Array)
        results ||= []
        mutex = Mutex.new

        thread1 = Thread.new do
          TreeHaver.with_backend(:rust) do
            parser = described_class.new
            mutex.synchronize { results << {thread: 1, backend: parser.backend} }
          end
        end

        thread2 = Thread.new do
          TreeHaver.with_backend(:citrus) do
            parser = described_class.new
            mutex.synchronize { results << {thread: 2, backend: parser.backend} }
          end
        end

        thread1.join
        thread2.join

        expect(results.size).to eq(2)
        expect(results.find { |r| r[:thread] == 1 }[:backend]).to eq(:rust)
        expect(results.find { |r| r[:thread] == 2 }[:backend]).to eq(:citrus)
      end

      it "creates parsers with explicit backends in concurrent threads" do
        # Use Rust and Citrus which can coexist (not FFI which conflicts with MRI)
        results = Concurrent::Array.new if defined?(Concurrent::Array)
        results ||= []
        mutex = Mutex.new

        thread1 = Thread.new do
          parser = described_class.new(backend: :rust)
          mutex.synchronize { results << {thread: 1, backend: parser.backend} }
        end

        thread2 = Thread.new do
          parser = described_class.new(backend: :citrus)
          mutex.synchronize { results << {thread: 2, backend: parser.backend} }
        end

        thread1.join
        thread2.join

        expect(results.size).to eq(2)
        expect(results.find { |r| r[:thread] == 1 }[:backend]).to eq(:rust)
        expect(results.find { |r| r[:thread] == 2 }[:backend]).to eq(:citrus)
      end
    end

    describe "Backward compatibility", :citrus_backend do
      it "works without backend parameter (existing behavior)" do
        parser = described_class.new
        expect(parser).to be_a(described_class)
      end

      it "respects global backend setting (existing behavior)" do
        # Use Citrus which doesn't conflict with MRI (not FFI)

        TreeHaver.backend = :citrus
        parser = described_class.new
        expect(parser.backend).to eq(:citrus)
      end
    end
  end

  describe "Parser initialization edge cases" do
    context "when tree-sitter fails and Citrus fallback is available" do
      let(:failing_backend_module) do
        mod = Module.new
        parser_class = Class.new do
          define_method(:initialize) do
            raise LoadError, "Simulated tree-sitter load failure"
          end
        end
        mod.const_set(:Parser, parser_class)
        mod
      end

      before do
        allow(TreeHaver).to receive(:resolve_backend_module).and_return(failing_backend_module)
        allow(TreeHaver::Backends::Citrus).to receive(:available?).and_return(true)
      end

      it "falls back to Citrus when tree-sitter backend fails with LoadError" do
        parser = described_class.new
        expect(parser.backend).to eq(:citrus)
      end
    end

    context "when tree-sitter fails with NoMethodError and Citrus available" do
      let(:failing_backend_module) do
        mod = Module.new
        parser_class = Class.new do
          define_method(:initialize) do
            raise NoMethodError, "Simulated method error"
          end
        end
        mod.const_set(:Parser, parser_class)
        mod
      end

      before do
        allow(TreeHaver).to receive(:resolve_backend_module).and_return(failing_backend_module)
        allow(TreeHaver::Backends::Citrus).to receive(:available?).and_return(true)
      end

      it "falls back to Citrus when tree-sitter backend fails with NoMethodError" do
        parser = described_class.new
        expect(parser.backend).to eq(:citrus)
      end
    end

    context "when tree-sitter fails and Citrus is NOT available" do
      let(:failing_backend_module) do
        mod = Module.new
        parser_class = Class.new do
          define_method(:initialize) do
            raise LoadError, "Simulated tree-sitter load failure"
          end
        end
        mod.const_set(:Parser, parser_class)
        mod
      end

      before do
        allow(TreeHaver).to receive(:resolve_backend_module).and_return(failing_backend_module)
        allow(TreeHaver::Backends::Citrus).to receive(:available?).and_return(false)
        allow(TreeHaver::Backends::Parslet).to receive(:available?).and_return(false)
      end

      it "raises NotAvailable with helpful message" do
        expect {
          described_class.new
        }.to raise_error(TreeHaver::NotAvailable, /Tree-sitter backend failed.*fallback not available/)
      end
    end

    context "when explicit backend requested and it fails" do
      let(:failing_backend_module) do
        mod = Module.new
        parser_class = Class.new do
          define_method(:initialize) do
            raise LoadError, "Backend specific failure"
          end
        end
        mod.const_set(:Parser, parser_class)
        mod
      end

      before do
        allow(TreeHaver).to receive(:resolve_backend_module).with(:failing_backend).and_return(failing_backend_module)
      end

      it "re-raises the error without fallback when explicit backend requested" do
        expect {
          described_class.new(backend: :failing_backend)
        }.to raise_error(LoadError, /Backend specific failure/)
      end
    end
  end

  describe "#backend" do
    it "detects FFI backend from implementation class name" do
      stub_const("ParserFFI", Class.new)
      parser = described_class.allocate
      parser.instance_variable_set(:@impl, ParserFFI.new)
      parser.instance_variable_set(:@explicit_backend, nil)

      expect(parser.backend).to eq(:ffi)
    end

    it "detects Java backend from implementation class name" do
      stub_const("ParserJava", Class.new)
      parser = described_class.allocate
      parser.instance_variable_set(:@impl, ParserJava.new)
      parser.instance_variable_set(:@explicit_backend, nil)

      expect(parser.backend).to eq(:java)
    end

    it "detects Parslet backend from implementation class name" do
      stub_const("ParserParslet", Class.new)
      parser = described_class.allocate
      parser.instance_variable_set(:@impl, ParserParslet.new)
      parser.instance_variable_set(:@explicit_backend, nil)

      expect(parser.backend).to eq(:parslet)
    end
  end

  describe "private #unwrap_language" do
    let(:parser) { described_class.allocate }

    it "unwraps MRI language via to_language" do
      allow(parser).to receive(:backend).and_return(:mri)
      lang = double("lang", backend: :mri, to_language: :raw_lang)

      expect(parser.send(:unwrap_language, lang)).to eq(:raw_lang)
    end

    it "unwraps MRI language via inner_language when to_language is missing" do
      allow(parser).to receive(:backend).and_return(:mri)
      lang = double("lang", backend: :mri, inner_language: :inner_lang)

      expect(parser.send(:unwrap_language, lang)).to eq(:inner_lang)
    end

    it "passes through MRI language when no unwrap method exists" do
      allow(parser).to receive(:backend).and_return(:mri)
      lang = double("lang", backend: :mri)

      expect(parser.send(:unwrap_language, lang)).to eq(lang)
    end

    it "unwraps Rust language via name" do
      allow(parser).to receive(:backend).and_return(:rust)
      lang = double("lang", backend: :rust, name: "toml")

      expect(parser.send(:unwrap_language, lang)).to eq("toml")
    end

    it "passes through Rust language when name is missing" do
      allow(parser).to receive(:backend).and_return(:rust)
      lang = double("lang", backend: :rust)

      expect(parser.send(:unwrap_language, lang)).to eq(lang)
    end

    it "passes through FFI language wrapper" do
      allow(parser).to receive(:backend).and_return(:ffi)
      lang = double("lang", backend: :ffi)

      expect(parser.send(:unwrap_language, lang)).to eq(lang)
    end

    it "unwraps Java language via impl" do
      allow(parser).to receive(:backend).and_return(:java)
      lang = double("lang", backend: :java, impl: :java_lang)

      expect(parser.send(:unwrap_language, lang)).to eq(:java_lang)
    end

    it "touches language mismatch branch when current language differs" do
      impl = Class.new { attr_accessor :language }.new
      impl.language = Object.new
      parser.instance_variable_set(:@impl, impl)
      allow(parser).to receive(:backend).and_return(:citrus)

      lang = double("lang", backend: :citrus)

      expect(parser.send(:unwrap_language, lang)).to eq(lang)
    end
  end

  describe "#parse_string fallback behavior" do
    context "when backend does not support parse_string" do
      let(:mock_tree) do
        mock_root = double("RootNode", type: "root", child_count: 0)
        double("MockTree", root_node: mock_root)
      end

      let(:backend_module) do
        tree = mock_tree
        mod = Module.new
        parser_class = Class.new do
          attr_accessor :language

          define_method(:initialize) { @tree = tree }

          define_method(:parse) { |_source| @tree }
          # No parse_string method
        end
        mod.const_set(:Parser, parser_class)
        mod
      end

      before do
        allow(TreeHaver).to receive(:resolve_backend_module).and_return(backend_module)
      end

      it "falls back to regular parse when parse_string not supported" do
        parser = described_class.new
        tree = parser.parse_string(nil, "test source")
        expect(tree).to be_a(TreeHaver::Tree)
      end

      it "falls back to regular parse even with old_tree when parse_string not supported" do
        parser = described_class.new
        old_tree = double("OldTree")
        tree = parser.parse_string(old_tree, "test source")
        expect(tree).to be_a(TreeHaver::Tree)
      end
    end
  end
end
