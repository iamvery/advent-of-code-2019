require "part"
require "point"

Wire = Struct.new(:points, :parts) do
  def self.parse(path)
    pieces = path.split(",")
    point = Point.new(0,0)
    part = Part.new(point, 0)
    points = []
    parts = []

    pieces.each do |piece|
      direction = piece[0]
      steps = Integer(piece[1..])
      steps.times do
        case direction
        when "U" then points << point = point.up
        when "D" then points << point = point.down
        when "R" then points << point = point.right
        when "L" then points << point = point.left
        else
          fail "unknown direction #{direction}"
        end
        parts << part = Part.new(point, part.step+1)
      end
    end

    new(points, parts)
  end

  def steps_at(point)
    points.find_index(point) + 1
  end
end
