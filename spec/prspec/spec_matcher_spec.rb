# frozen_string_literal: true

RSpec.describe Rrspec::Ruby::SpecMatcher do
  subject(:matcher) { described_class.new }

  it "guesses candidate spec paths for lib files" do
    expect(matcher.candidate_paths("lib/foo/bar.rb")).to eq([
      "spec/foo/bar_spec.rb",
      "spec/lib/foo/bar_spec.rb"
    ])
  end

  it "guesses candidate spec paths for app files" do
    expect(matcher.candidate_paths("app/services/foo/bar.rb")).to eq([
      "spec/services/foo/bar_spec.rb",
      "spec/app/services/foo/bar_spec.rb"
    ])
  end
end
