require "space/orbits"

RSpec.describe Space::Orbits do
  it "parses orbit data" do
    orbit_data = <<~DATA
      COM)B
      B)C
      C)D
      D)E
      E)F
      B)G
      G)H
      D)I
      E)J
      J)K
      K)L
    DATA

    orbits = described_class.process(orbit_data)

    expect(orbits.indirect_orbits).to eq(42)
  end

  it "handles randomly-ordered orbit data" do
    orbit_data = <<~DATA
      B)C
      A)B
      COM)A
    DATA

    orbits = described_class.process(orbit_data)
    com = Space::Body.new("COM")
    a = Space::Body.new("A", com)
    b = Space::Body.new("B", a)
    c = Space::Body.new("C", b)
    expect(orbits.bodies).to eq(
      "COM" => com,
      "A" => a,
      "B" => b,
      "C" => c,
    )
  end

  it "calculates orbit transfers" do
    orbit_data = <<~DATA
      COM)B
      B)C
      C)D
      D)E
      E)F
      B)G
      G)H
      D)I
      E)J
      J)K
      K)L
      K)YOU
      I)SAN
    DATA

    orbits = described_class.process(orbit_data)
    transfers = orbits.minimum_transfers("YOU", "SAN")

    expect(transfers).to eq(4)
  end
end
