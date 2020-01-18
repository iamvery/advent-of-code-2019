require "space/body"

RSpec.describe Space::Body do
  it "counts indirect orbits" do
    body = described_class.new(
      "C",
      described_class.new(
        "B",
        described_class.new("A"),
      ),
    )
    expect(body.indirect_orbits).to eq(2)
  end
end
