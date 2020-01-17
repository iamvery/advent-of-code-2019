require "space/body"

RSpec.describe Space::Body do
  it "counts indirect orbits" do
    body = described_class.new(
      described_class.new(
        described_class.new,
      ),
    )
    expect(body.indirect_orbits).to eq(2)
  end
end
