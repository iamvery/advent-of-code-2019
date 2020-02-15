require "point"

module Space
  class Simulation
    # https://rubular.com/r/ULUqpWzQjwcEy6
    LINE_EXPR = /<x=(?<x>-?\d+), y=(?<y>-?\d+), z=(?<z>-?\d+)>/

    Moon = Struct.new(:position, :velocity) do
      def potential_energy
        position.x.abs + position.y.abs + position.z.abs
      end

      def kinetic_energy
        velocity.x.abs + velocity.y.abs + velocity.z.abs
      end

      def total_energy
        potential_energy * kinetic_energy
      end
    end

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

    def self.detect_repetition(data)
      initial = parse(data)
      simulation = parse(data)

      %i(x y z).map { |axis|
        count = 0
        loop do
          count += simulation.step_axis(axis, 1)
          break count if initial.moons == simulation.moons
        end
      }.reduce(:lcm)
    end

    attr_reader :moons

    def initialize(points)
      @moons = points.map { |position|
        Moon.new(position, Point.new(0,0,0))
      }
    end

    def step(count)
      step_axis(:x, count)
      step_axis(:y, count)
      step_axis(:z, count)
    end

    def step_axis(axis, count)
      count.times do
        moons.combination(2) do |a,b|
          offset = a.position[axis] <=> b.position[axis]
          a.velocity[axis] += -offset
          b.velocity[axis] +=  offset
        end

        moons.each do |moon|
          moon.position[axis] += moon.velocity[axis]
        end
      end
    end

    def total_energy
      moons.map(&:total_energy).sum
    end
  end
end
