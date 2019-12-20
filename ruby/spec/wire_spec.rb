require "wire"
require "point"

RSpec.describe Wire do
  describe ".parse" do
    it "traverses path to generate points" do
      wire = Wire.parse("U2,R3")
      expect(wire.points).to match_array([
        Point.new(0,1),
        Point.new(0,2),
        Point.new(1,2),
        Point.new(2,2),
        Point.new(3,2),
      ])
    end
  end
end
