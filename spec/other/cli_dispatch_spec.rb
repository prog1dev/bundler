# frozen_string_literal: true

RSpec.describe "bundle command names" do
  it "work when given fully" do
    bundle "install"
    expect(err).to lack_errors
    expect(out).not_to match(/Ambiguous command/)
  end

  it "work when not ambiguous" do
    bundle "ins"
    expect(err).to lack_errors
    expect(out).not_to match(/Ambiguous command/)
  end

  it "print a friendly error when ambiguous" do
    bundle "in"
    expect(err).to lack_errors
    expect(out).to match(/Ambiguous command/)
  end

  context "when cache_command_is_package is set" do
    before { bundle! "config cache_command_is_package true" }

    it "dispatches `bundle cache` to the package command" do
      bundle "cache --verbose"
      expect(out).to start_with "Running `bundle package --verbose --no-color`"
    end
  end
end
