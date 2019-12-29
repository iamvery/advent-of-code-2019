require "wire"
require "point"

class Wiring
  def initialize(path1, path2)
    @wire1 = Wire.parse(path1)
    @wire2 = Wire.parse(path2)
  end

  def distance
    intersections.map { |p| manhattan_distance(Point.new(0,0), p) }.min
  end

  private

  def intersections
    @wire1.points & @wire2.points
  end

  def manhattan_distance(point1, point2)
    (point1.x - point2.x).abs + (point1.y - point2.y).abs
  end
end
