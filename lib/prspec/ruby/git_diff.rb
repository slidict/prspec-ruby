# frozen_string_literal: true

module Rrspec
  module Ruby
    class GitDiff
      DEFAULT_RANGE = "HEAD".freeze

      def initialize(range = nil)
        @range = range
      end

      def changed_files
        output, status = Open3.capture2e(*command)
        return [] unless status.success?

        output.lines.map(&:chomp).reject(&:empty?)
      end

      private

      attr_reader :range

      def command
        ["git", "diff", "--name-only", range || DEFAULT_RANGE]
      end
    end
  end
end
