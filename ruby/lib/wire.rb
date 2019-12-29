require "part"
require "point"

Wire = Struct.new(:parts) do
  def self.parse(path)
    pieces = path.split(",")
    point = Point.new(0,0)
    part = Part.new(point, 0)
    parts = []

    pieces.each do |piece|
      direction = piece[0]
      steps = Integer(piece[1..])
      steps.times do
        case direction
        when "U" then point = point.up
        when "D" then point = point.down
        when "R" then point = point.right
        when "L" then point = point.left
        else
          fail "unknown direction #{direction}"
        end
        parts << part = Part.new(point, part.step+1)
      end
    end

    new(parts)
  end

  def points
    parts.map(&:point)
  end
end
