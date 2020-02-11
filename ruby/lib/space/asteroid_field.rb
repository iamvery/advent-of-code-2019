require "point"

module Space
  Asteroid = Struct.new(:point, :field) do
    def detections
      other_asteroids_by_lines.values.map { |asteroids|
        asteroids
          .partition { |a| (point.x - a.point.x).positive? }
          .count { |p| !p.empty? }
      }.sum
    end

    private

    def other_asteroids_by_lines
      other_asteroids.group_by { |other| slope(point, other.point) }
    end

    def other_asteroids
      field.asteroids - [self]
    end

    def slope(p1, p2)
      (p2.y - p1.y).to_f / (p2.x - p1.x).to_f
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
