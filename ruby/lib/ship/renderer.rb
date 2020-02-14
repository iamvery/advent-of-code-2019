class Ship
  class Renderer
    attr_reader :output

    def initialize(output = $stdout)
      @output = output
    end

    def render(ship)
      points = ship.panels.values.map(&:point)
      min_x = points.map(&:x).min
      max_x = points.map(&:x).max
      min_y = points.map(&:y).min
      max_y = points.map(&:y).max

      (min_y..max_y).to_a.reverse.each do |y|
        (min_x..max_x).each do |x|
          panel = ship.get_panel(Point.new(x,y))
          case color = panel.color
          when Ship::Panel::BLACK then output.print "█"
          when Ship::Panel::WHITE then output.print "░"
          else
            fail "Unknown color: #{color}"
          end
        end
        output.print "\n"
      end
    end
  end
end
