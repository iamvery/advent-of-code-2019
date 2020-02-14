class Ship
  class Panel < Struct.new(:point, :color)
    BLACK = 0
    WHITE = 1

    def initialize(point, color = nil)
      super(point, color || BLACK)
    end
  end

  attr_reader :panels

  def initialize
    @panels = Hash.new { |h, point| h[point] = Panel.new(point) }
  end

  def get_panel(point)
    panels[point]
  end
end
