# frozen_string_literal: true

module TreeHaver
  module Base
    # Base class for backend comment wrappers.
    #
    # This defines the parser-facing contract for normalized comment wrappers in
    # TreeHaver. Backends that can expose comment objects should subclass this and
    # implement text/type/location accessors using their native parser data.
    class Comment
      ATTACHMENT_HINTS = %i[leading inline trailing].freeze

      # The underlying backend-specific comment object.
      # @return [Object]
      attr_reader :inner_comment

      # The source text used for fallback range extraction.
      # @return [String, nil]
      attr_reader :source

      # Optional parser-provided attachment hint.
      # @return [Symbol, nil]
      attr_reader :attachment_hint

      def initialize(comment, source: nil, attachment_hint: nil)
        @inner_comment = comment
        @source = source
        @attachment_hint = normalize_attachment_hint(attachment_hint)
      end

      # Get the normalized comment type.
      # Examples: "inline_comment", "block_comment".
      # @return [String]
      def type
        raise NotImplementedError, "#{self.class}#type must be implemented"
      end

      # Get the comment text including delimiters when appropriate.
      # @return [String]
      def text
        raise NotImplementedError, "#{self.class}#text must be implemented"
      end

      # Get the start byte offset of the comment.
      # @return [Integer]
      def start_byte
        raise NotImplementedError, "#{self.class}#start_byte must be implemented"
      end

      # Get the end byte offset of the comment.
      # @return [Integer]
      def end_byte
        raise NotImplementedError, "#{self.class}#end_byte must be implemented"
      end

      # Get the start position (row/column, 0-based).
      # @return [Hash{Symbol => Integer}]
      def start_point
        {row: 0, column: 0}
      end

      # Get the end position (row/column, 0-based).
      # @return [Hash{Symbol => Integer}]
      def end_point
        {row: 0, column: 0}
      end

      # Get the normalized delimiter style.
      # @return [Symbol, nil]
      def style
        nil
      end

      def attachment_hint?
        !attachment_hint.nil?
      end

      def leading?
        attachment_hint == :leading
      end

      def inline?
        attachment_hint == :inline
      end

      def trailing?
        attachment_hint == :trailing
      end

      def start_line
        start_point[:row] + 1
      end

      def end_line
        end_point[:row] + 1
      end

      def source_position
        {
          start_line: start_line,
          end_line: end_line,
          start_column: start_point[:column],
          end_column: end_point[:column],
        }
      end

      def inspect
        "#<#{self.class} type=#{type.inspect} range=#{start_byte}...#{end_byte}>"
      end

      private

      def normalize_attachment_hint(hint)
        return nil if hint.nil?

        normalized = hint.to_sym
        return normalized if ATTACHMENT_HINTS.include?(normalized)

        raise ArgumentError,
          "Unknown comment attachment hint: #{hint.inspect}. Expected one of: #{ATTACHMENT_HINTS.join(', ')}"
      end
    end
  end
end
