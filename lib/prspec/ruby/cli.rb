# frozen_string_literal: true

module Rrspec
  module Ruby
    class CLI
      def initialize(argv, out: $stdout)
        @argv = argv.dup
        @out = out
      end

      def run
        command = argv.shift

        case command
        when "review"
          run_review
        when "version", "--version", "-v"
          out.puts VERSION
          0
        when "help", nil, "--help", "-h"
          print_help
          0
        else
          out.puts "Unknown command: #{command}"
          print_help
          1
        end
      end

      private

      attr_reader :argv, :out

      def run_review
        fail_on_warning = argv.delete("--fail-on-warning")
        range = argv.shift
        issues = Reviewer.new(GitDiff.new(range).changed_files).issues

        out.puts "prspec review"
        out.puts

        if issues.empty?
          out.puts "No test risks found."
          return 0
        end

        issues.each do |issue|
          print_issue(issue)
          out.puts
        end
        out.puts "#{issues.size} issues found."

        fail_on_warning ? 1 : 0
      end

      def print_issue(issue)
        out.puts issue.type.to_s.upcase.tr("_", " ")
        out.puts issue.path
        out.puts issue.message
        return if issue.expected_specs.empty?

        out.puts "Expected one of:"
        issue.expected_specs.each { |path| out.puts "- #{path}" }
      end

      def print_help
        out.puts <<~HELP
          prspec - test risk review for Ruby/RSpec projects

          Usage:
            prspec review [git-range] [--fail-on-warning]
            prspec version
            prspec help
        HELP
      end
    end
  end
end
