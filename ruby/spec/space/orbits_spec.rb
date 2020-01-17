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

    bodies = described_class.process(orbit_data)
    indirect_orbits = bodies.values.map(&:indirect_orbits).reduce(&:+)

    expect(indirect_orbits).to eq(42)
  end
end
