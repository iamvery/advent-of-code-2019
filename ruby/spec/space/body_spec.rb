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

  it "enumerates orbited bodies" do
    a = described_class.new("A")
    b = described_class.new("B", a)
    c = described_class.new("C", b)

    expect(c.bodies.to_a).to eq([b,a])
  end
end
