require "point"

module Space
  Asteroid = Struct.new(:point)

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
      @asteroids = points.map { |p| Asteroid.new(p) }
    end

    def ideal
      asteroids.map { |asteroid|
        other_asteroids = asteroids - [asteroid]
        total = other_asteroids
          # gather points into groups with the same slope (on the same line) relative to the current point
          .group_by { |other| slope(asteroid.point, other.point) }
          # count the number of "visible" points on each line
          .map { |_slope, points_on_line|
            # For any slope, there is at most 2 visible points
            near_points = points_on_line.sort_by { |p| distance(asteroid.point, p.point) }.take(2)
            next 1 unless near_points.length > 1
            a,b = near_points
            # Make sure that the two nearest points aren't on the "same side" and blocking one another
            next 1 if between(asteroid.point, a.point, b.point)
            next 1 if between(asteroid.point, b.point, a.point)
            next 2
        }.sum
        [asteroid.point, total]
      # sort such that the points with the highest total (most visible points)
      # is last and grab that one, then grab the first element of the result which
      # is the point itself
      }.sort_by(&:last).last
    end

    private

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
end
