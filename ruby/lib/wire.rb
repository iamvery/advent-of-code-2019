require "point"

Wire = Struct.new(:points) do
  def self.parse(path)
    parts = path.split(",")
    point = Point.new(0,0)
    points = []

    parts.each do |part|
      direction = part[0]
      steps = Integer(part[1..])
      steps.times do
        case direction
        when "U" then points << point = point.up
        when "D" then points << point = point.down
        when "R" then points << point = point.right
        when "L" then points << point = point.left
        else
          fail "unknown direction #{direction}"
        end
      end
    end

    new(points)
  end
end
