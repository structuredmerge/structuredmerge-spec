# frozen_string_literal: true

require "spec_helper"

RSpec.describe TreeHaver::Base::Comment do
  subject(:comment) { comment_class.new(Object.new, source: "x\n  # hello\n") }

  let(:comment_class) do
    Class.new(described_class) do
      def type
        "inline_comment"
      end

      def text
        "# hello"
      end

      def start_byte
        3
      end

      def end_byte
        10
      end

      def start_point
        {row: 1, column: 2}
      end

      def end_point
        {row: 1, column: 9}
      end

      def style
        :line
      end
    end
  end

  describe "#start_line" do
    it "converts 0-based rows to 1-based line numbers" do
      expect(comment.start_line).to eq(2)
    end
  end

  describe "#end_line" do
    it "converts 0-based rows to 1-based line numbers" do
      expect(comment.end_line).to eq(2)
    end
  end

  describe "#source_position" do
    it "returns a normalized range hash" do
      expect(comment.source_position).to eq(
        start_line: 2,
        end_line: 2,
        start_column: 2,
        end_column: 9,
      )
    end
  end

  describe "attachment hints" do
    it "defaults to no hint" do
      expect(comment.attachment_hint).to be_nil
      expect(comment.attachment_hint?).to be(false)
    end

    it "defaults the ownership predicates to false" do
      expect(comment.leading?).to be(false)
      expect(comment.inline?).to be(false)
      expect(comment.trailing?).to be(false)
    end

    it "normalizes supported hint values" do
      hinted_comment = comment_class.new(Object.new, attachment_hint: "inline")

      expect(hinted_comment.attachment_hint).to eq(:inline)
      expect(hinted_comment.attachment_hint?).to be(true)
      expect(hinted_comment.inline?).to be(true)
    end

    it "rejects unknown hint values" do
      expect {
        comment_class.new(Object.new, attachment_hint: :orphan)
      }.to raise_error(ArgumentError, /Unknown comment attachment hint/)
    end
  end

  describe "#inspect" do
    it "includes the normalized type and byte range" do
      expect(comment.inspect).to include("inline_comment")
      expect(comment.inspect).to include("3...10")
    end
  end
end
