# frozen_string_literal: true

module Rrspec
  module Ruby
    Issue = Struct.new(:type, :path, :message, :expected_specs, keyword_init: true) do
      def missing_spec?
        type == :missing_spec
      end
    end
  end
end
