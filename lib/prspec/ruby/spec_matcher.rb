# frozen_string_literal: true

module Rrspec
  module Ruby
    class SpecMatcher
      def candidate_paths(path)
        without_extension = path.sub(/\.rb\z/, "")
        stripped = without_extension.sub(%r{\A(?:app|lib)/}, "")

        [
          "spec/#{stripped}_spec.rb",
          "spec/#{without_extension}_spec.rb"
        ].uniq
      end

      def matching_spec_changed?(path, changed_files)
        candidates = candidate_paths(path)
        changed_files.any? { |changed_file| candidates.include?(changed_file) }
      end
    end
  end
end
