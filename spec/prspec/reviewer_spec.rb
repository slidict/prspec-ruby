# frozen_string_literal: true

RSpec.describe Rrspec::Ruby::Reviewer do
  it "warns when a matching spec has not changed" do
    issues = described_class.new(["lib/billing/refund_calculator.rb"]).issues

    expect(issues.map(&:type)).to eq(%i[missing_spec risky_change])
  end

  it "does not warn when a matching spec changed" do
    issues = described_class.new([
      "lib/billing/refund_calculator.rb",
      "spec/billing/refund_calculator_spec.rb"
    ]).issues

    expect(issues).to be_empty
  end
end
