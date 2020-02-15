require "point"
require "space/simulation"

RSpec.describe Space::Simulation do
  describe ".parse" do
    it "returns simulation created from data" do
      data = <<~DATA
        <x=-1, y=0, z=2>
        <x=2, y=-10, z=-7>
        <x=4, y=-8, z=8>
        <x=3, y=5, z=-1>
      DATA

      simulation = described_class.parse(data)

      expect(simulation.moons).to match_array([
        described_class::Moon.new(Point.new(-1,0,2), Point.new(0,0,0)),
        described_class::Moon.new(Point.new(2,-10,-7), Point.new(0,0,0)),
        described_class::Moon.new(Point.new(4,-8,8), Point.new(0,0,0)),
        described_class::Moon.new(Point.new(3,5,-1), Point.new(0,0,0)),
      ])
    end
  end
end
