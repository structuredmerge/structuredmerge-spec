# frozen_string_literal: true

RSpec.describe "CONTRIBUTING template sync" do
  it "keeps kettle-test guidance unique while preserving backend testing notes" do
    content = File.read(File.expand_path("../../CONTRIBUTING.md", __dir__))

    expect(content.scan("Run tests via `kettle-test`").size).to eq(1)
    expect(content).to include("## Backend Compatibility Testing")
    expect(content).to include("Start with the standard `kettle-test` workflow in the [Run Tests](#run-tests) section below.")
  end
end
