# frozen_string_literal: true

module Rrspec
  module Ruby
    class Reviewer
      def initialize(changed_files, classifier: FileClassifier.new, matcher: SpecMatcher.new)
        @changed_files = changed_files
        @classifier = classifier
        @matcher = matcher
      end

      def issues
        reviewable_files.flat_map do |path|
          next [] if matcher.matching_spec_changed?(path, changed_files)

          [
            Issue.new(
              type: :missing_spec,
              path: path,
              message: "No matching spec changed.",
              expected_specs: matcher.candidate_paths(path)
            ),
            Issue.new(
              type: :risky_change,
              path: path,
              message: "Ruby file changed without spec updates.",
              expected_specs: []
            )
          ]
        end
      end

      private

      attr_reader :changed_files, :classifier, :matcher

      def reviewable_files
        changed_files.select { |path| classifier.reviewable_ruby_file?(path) }
      end
    end
  end
end
