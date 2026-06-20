# frozen_string_literal: true

RSpec.describe Rrspec::Ruby::CLI do
  it "returns exit status 1 for warnings with --fail-on-warning" do
    allow(Rrspec::Ruby::GitDiff).to receive(:new).with(nil).and_return(instance_double(Rrspec::Ruby::GitDiff, changed_files: ["lib/foo.rb"]))

    expect(described_class.new(["review", "--fail-on-warning"], out: StringIO.new).run).to eq(1)
  end

  it "runs version" do
    out = StringIO.new

    expect(described_class.new(["version"], out: out).run).to eq(0)
    expect(out.string).to include(Rrspec::Ruby::VERSION)
  end

  it "runs help" do
    out = StringIO.new

    expect(described_class.new(["help"], out: out).run).to eq(0)
    expect(out.string).to include("prspec review")
  end
end
