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
      count = 0
      loop do
        count += simulation.step(1)
        break count if initial.moons == simulation.moons
      end
    end

    attr_reader :moons

    def initialize(points)
      @moons = points.map { |position|
        Moon.new(position, Point.new(0,0,0))
      }
    end

    def step(count)
      count.times do
        moons.combination(2) do |a,b|
          apply_gravity(a,b)
        end
        moons.each(&method(:apply_velocity))
      end
    end

    def total_energy
      moons.map(&:total_energy).sum
    end

    private

    def apply_gravity(a,b)
      case a.position.x <=> b.position.x
      when -1
        a.velocity.x += 1
        b.velocity.x -= 1
      when 1
        a.velocity.x -= 1
        b.velocity.x += 1
      end

      case a.position.y <=> b.position.y
      when -1
        a.velocity.y += 1
        b.velocity.y -= 1
      when 1
        a.velocity.y -= 1
        b.velocity.y += 1
      end

      case a.position.z <=> b.position.z
      when -1
        a.velocity.z += 1
        b.velocity.z -= 1
      when 1
        a.velocity.z -= 1
        b.velocity.z += 1
      end
    end

    def apply_velocity(moon)
      moon.position.x += moon.velocity.x
      moon.position.y += moon.velocity.y
      moon.position.z += moon.velocity.z
    end
  end
end
