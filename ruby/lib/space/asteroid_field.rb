require "point"

module Space
  Asteroid = Struct.new(:point, :field) do
    def detections
      other_asteroids_by_angle.length
    end

    private

    def other_asteroids_by_angle
      other_asteroids.group_by { |a| angle(point, a.point) }
    end

    def other_asteroids
      field.asteroids - [self]
    end

    def angle(a, b)
      # Since the asteroid system is not laid out like the traditional
      # coordinate system where theta = 0 along the x-axis and theta is
      # positive as you rotate counter-clockwise from there. For
      # asteroids, theta is zero along the y-axis and rotates clockwise.
      # To accomodate for this difference, a couple adjustments must be
      # made:
      #
      # - The xs and ys are transposed on the all to Math.atan2. This
      #   "rotates" the coordinate system 90 degrees effectively moving
      #   theta = 0 to the y-axis.
      # - The result is deducted from from PI. This has two nice effects.
      #   First, and most importantly, it reverses the rotation of theta
      #   to be clockwise. Second is shifts the results from -PI:PI to
      #   0:2PI which is handy in the cycle used for vaporizing asteroids.
      Math::PI - Math.atan2(b.x - a.x, b.y - a.y)
    end
  end

  class AsteroidField
    def self.parse(data)
      new data.split.flat_map.with_index { |row, y|
        row.split("").map.with_index { |s, x|
          Point.new(x,y) if s == "#"
        }
      }.compact
    end

    attr_reader :asteroids

    def initialize(points)
      @asteroids = points.map { |p| Asteroid.new(p, self) }
    end

    def ideal
      asteroid = asteroids.sort_by(&:detections).last
      [asteroid.point, asteroid.detections]
    end
  end
end
