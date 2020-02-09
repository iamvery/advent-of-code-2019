require "point"

module Space
  Asteroid = Struct.new(:point, :field) do
    def detections
      other_asteroids_by_lines
        .map { |asteroids_on_line|
          # For any slope, there is at most 2 visible points
          nearby = asteroids_on_line.sort_by { |a| distance(point, a.point) }.take(2)
          next 1 unless nearby.length > 1
          a,b = nearby
          # Make sure that the two nearest points aren't on the "same side" and blocking one another
          next 1 if between(point, a.point, b.point)
          next 1 if between(point, b.point, a.point)
          next 2
      }.sum
    end

    private

    def other_asteroids_by_lines
      other_asteroids
        .group_by { |other| slope(point, other.point) }
        .values
    end

    def other_asteroids
      field.asteroids - [self]
    end

    def slope(p1, p2)
      (p2.y - p1.y).to_f / (p2.x - p1.x).to_f
    end

    def distance(p1, p2)
      Math.sqrt((p1.x - p2.x)**2 + (p1.y - p2.y)**2)
    end

    def between(a, b, c)
      # Floating poing math becomes an issue, but precision 10 is more than
      # adequate for this test since the grid these points is layed out on is in
      # whole units.
      (distance(a,b) + distance(b,c)).round(10) == distance(a,c).round(10)
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
