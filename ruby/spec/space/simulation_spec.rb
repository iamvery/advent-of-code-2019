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

      expect(simulation.moons).to eq([
        described_class::Moon.new(Point.new(-1,0,2), Point.new(0,0,0)),
        described_class::Moon.new(Point.new(2,-10,-7), Point.new(0,0,0)),
        described_class::Moon.new(Point.new(4,-8,8), Point.new(0,0,0)),
        described_class::Moon.new(Point.new(3,5,-1), Point.new(0,0,0)),
      ])
    end
  end

  describe "#step" do
    it "works with first example" do
      data = <<~DATA
        <x=-1, y=0, z=2>
        <x=2, y=-10, z=-7>
        <x=4, y=-8, z=8>
        <x=3, y=5, z=-1>
      DATA

      simulation = described_class.parse(data)

      simulation.step(1)
      expect(simulation.moons).to eq([
        described_class::Moon.new(Point.new(2,-1,1), Point.new(3,-1,-1)),
        described_class::Moon.new(Point.new(3,-7,-4), Point.new(1,3,3)),
        described_class::Moon.new(Point.new(1,-7,5), Point.new(-3,1,-3)),
        described_class::Moon.new(Point.new(2,2,0), Point.new(-1,-3,1)),
      ])
      simulation.step(1) # 2 steps
      expect(simulation.moons).to eq([
        described_class::Moon.new(Point.new(5,-3,-1), Point.new(3,-2,-2,)),
        described_class::Moon.new(Point.new(1,-2,2), Point.new(-2,5,6)),
        described_class::Moon.new(Point.new(1,-4,-1), Point.new(0,3,-6)),
        described_class::Moon.new(Point.new(1,-4,2), Point.new(-1,-6,2)),
      ])
      simulation.step(8) # 10 steps
      expect(simulation.moons).to eq([
        described_class::Moon.new(Point.new(2,1,-3), Point.new(-3,-2,1)),
        described_class::Moon.new(Point.new(1,-8,0), Point.new(-1,1,3)),
        described_class::Moon.new(Point.new(3,-6,1), Point.new(3,2,-3)),
        described_class::Moon.new(Point.new(2,0,4), Point.new(1,-1,-1)),
      ])
    end
  end
end
