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

      def opening_delimiter
        "#"
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

  describe "source-adjacent layout metadata" do
    it "reports file-edge position" do
      expect(comment).not_to be_at_file_start
      expect(comment).to be_at_file_end
    end

    it "reports contiguous blank lines around the comment" do
      expect(comment.blank_lines_before).to eq([])
      expect(comment.blank_lines_after).to eq([])
      expect(comment.blank_line_count_before).to eq(0)
      expect(comment.blank_line_count_after).to eq(0)
    end

    it "tracks blank-line runs before and after multi-line-separated comments" do
      separated_comment = Class.new(comment_class) do
        def start_point
          {row: 2, column: 0}
        end

        def end_point
          {row: 2, column: 7}
        end
      end.new(
        Object.new,
        source: "intro\n\n# hello\n\n\nbody\n",
      )

      expect(separated_comment.blank_lines_before).to eq([""])
      expect(separated_comment.blank_lines_after).to eq(["", ""])
      expect(separated_comment.blank_line_count_before).to eq(1)
      expect(separated_comment.blank_line_count_after).to eq(2)
    end

    it "treats line-1 comments as file-start anchored" do
      start_comment = Class.new(comment_class) do
        def start_point
          {row: 0, column: 0}
        end

        def end_point
          {row: 0, column: 7}
        end
      end.new(Object.new, source: "# hello\nbody\n")

      expect(start_comment).to be_at_file_start
      expect(start_comment.blank_lines_before).to eq([])
    end
  end

  describe "normalized text helpers" do
    it "extracts the comment body without delimiters" do
      expect(comment.body_text).to eq("hello")
    end

    it "returns a stripped matching-friendly normalized body" do
      expect(comment.normalized_text).to eq("hello")
    end

    it "exposes delimiter metadata" do
      expect(comment.delimiter_metadata).to eq(
        opening: "#",
        closing: nil,
        body: "hello",
      )
    end

    it "classifies line and multiline behavior" do
      expect(comment.line?).to be(true)
      expect(comment.block?).to be(false)
      expect(comment.multiline?).to be(false)
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
