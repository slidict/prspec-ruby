# frozen_string_literal: true

require "English"
require "open3"

require_relative "ruby/version"
require_relative "ruby/issue"
require_relative "ruby/file_classifier"
require_relative "ruby/spec_matcher"
require_relative "ruby/git_diff"
require_relative "ruby/reviewer"
require_relative "ruby/cli"

module Rrspec
  module Ruby
    class Error < StandardError; end
  end
end
