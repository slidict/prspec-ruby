# frozen_string_literal: true

module Rrspec
  module Ruby
    class FileClassifier
      def ruby_file?(path)
        path.end_with?(".rb")
      end

      def spec_file?(path)
        path.start_with?("spec/")
      end

      def reviewable_ruby_file?(path)
        ruby_file?(path) && !spec_file?(path)
      end
    end
  end
end
