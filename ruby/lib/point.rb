Point = Struct.new(:x, :y) do
  def up
    Point.new(x, y+1)
  end

  def down
    Point.new(x, y-1)
  end

  def right
    Point.new(x+1, y)
  end

  def left
    Point.new(x-1, y)
  end
end
