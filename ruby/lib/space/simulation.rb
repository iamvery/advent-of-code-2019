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
      x_count = 0
      loop do
        x_count += simulation.step_x(1)
        break if initial.moons == simulation.moons
      end
      y_count = 0
      loop do
        y_count += simulation.step_y(1)
        break if initial.moons == simulation.moons
      end
      z_count = 0
      loop do
        z_count += simulation.step_z(1)
        break if initial.moons == simulation.moons
      end
      [x_count, y_count, z_count].reduce(1, :lcm)
    end

    attr_reader :moons

    def initialize(points)
      @moons = points.map { |position|
        Moon.new(position, Point.new(0,0,0))
      }
    end

    def step(count)
      step_x(count)
      step_y(count)
      step_z(count)
    end

    def step_x(count)
      count.times do
        moons.combination(2) do |a,b|
          offset = a.position.x <=> b.position.x
          a.velocity.x += -offset
          b.velocity.x +=  offset
        end

        moons.each do |moon|
          moon.position.x += moon.velocity.x
        end
      end
    end

    def step_y(count)
      count.times do
        moons.combination(2) do |a,b|
          y_offset = a.position.y <=> b.position.y
          a.velocity.y += -y_offset
          b.velocity.y +=  y_offset
        end

        moons.each do |moon|
          moon.position.y += moon.velocity.y
        end
      end
    end

    def step_z(count)
      count.times do
        moons.combination(2) do |a,b|
          z_offset = a.position.z <=> b.position.z
          a.velocity.z += -z_offset
          b.velocity.z +=  z_offset
        end

        moons.each do |moon|
          moon.position.z += moon.velocity.z
        end
      end
    end
    def total_energy
      moons.map(&:total_energy).sum
    end
  end
end
