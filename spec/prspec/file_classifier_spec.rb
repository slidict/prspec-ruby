# frozen_string_literal: true

RSpec.describe Rrspec::Ruby::FileClassifier do
  subject(:classifier) { described_class.new }

  it "detects Ruby files" do
    expect(classifier.ruby_file?("lib/foo.rb")).to be(true)
    expect(classifier.ruby_file?("README.md")).to be(false)
  end

  it "ignores spec files for review" do
    expect(classifier.reviewable_ruby_file?("spec/foo_spec.rb")).to be(false)
  end
end
