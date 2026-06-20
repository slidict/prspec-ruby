# frozen_string_literal: true

RSpec.describe Rrspec::Ruby::GitDiff do
  it "gets changed files from git diff" do
    status = instance_double(Process::Status, success?: true)

    allow(Open3).to receive(:capture2e)
      .with("git", "diff", "--name-only", "HEAD~1")
      .and_return(["lib/foo.rb\nspec/foo_spec.rb\n", status])

    expect(described_class.new("HEAD~1").changed_files).to eq(["lib/foo.rb", "spec/foo_spec.rb"])
  end
end
