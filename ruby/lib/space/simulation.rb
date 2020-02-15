require "point"

module Space
  class Simulation
    # https://rubular.com/r/ULUqpWzQjwcEy6
    LINE_EXPR = /<x=(?<x>-?\d+), y=(?<y>-?\d+), z=(?<z>-?\d+)>/

    Moon = Struct.new(:position, :velocity)

    def self.parse(data)
      points = data.split("\n").map { |line|
        match_data = line.match(LINE_EXPR)
        x = Integer(match_data[:x])
        y = Integer(match_data[:y])
        z = Integer(match_data[:z])
        Point.new(x,y,z)
      }
      new(points)
    end

    attr_reader :moons

    def initialize(points)
      @moons = points.map { |position|
        Moon.new(position, Point.new(0,0,0))
      }
    end
  end
end
