require "point"

Wire = Struct.new(:points) do
  def self.parse(path)
    pieces = path.split(",")
    point = Point.new(0,0)

    points = pieces.flat_map do |piece|
      direction = piece[0]
      steps = Integer(piece[1..])
      steps.times.reduce([]) do |points, _|
        case direction
        when "U" then point = point.up
        when "D" then point = point.down
        when "R" then point = point.right
        when "L" then point = point.left
        else
          fail "unknown direction #{direction}"
        end

        points << point
      end
    end

    new(points)
  end

  def steps_at(point)
    points.find_index(point) + 1
  end
end
