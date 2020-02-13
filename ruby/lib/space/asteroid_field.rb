require "point"

module Space
  Asteroid = Struct.new(:point, :field) do
    def vaporize
      # Reverse the sorted list of angles such that they cycle clockwise.
      angles = other_asteroids_by_angle.keys.sort.reverse
      others = other_asteroids_by_angle.dup
      angles.cycle.lazy
        .take_while { !others.values.flatten.empty? }
        .map { |angle| others[angle].shift }
        .to_a.compact
    end

    def detections
      other_asteroids_by_angle.length
    end

    private

    def other_asteroids_by_angle
      @other_asteroids_by_angle||= other_asteroids.group_by { |a| angle(point, a.point) }
    end

    def other_asteroids
      @other_asteroids ||= (field.asteroids - [self]).sort_by { |a| distance(point, a.point) }
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
      Math.atan2(b.x - a.x, b.y - a.y)
    end

    def distance(a, b)
      Math.sqrt((a.x - b.x)**2 + (a.y - b.y)**2)
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
      [ideal_asteroid.point, ideal_asteroid.detections]
    end

    def vaporize
      ideal_asteroid.vaporize
    end

    private

    def ideal_asteroid
      @ideal_asteroid ||= asteroids.sort_by(&:detections).last
    end
  end
end
