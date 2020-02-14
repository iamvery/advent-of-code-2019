require "ship"
require "point"
require "direction"

class Ship::Robot
  attr_reader :ship, :position, :direction

  def initialize(brain)
    @ship = Ship.new
    @brain = brain
    @position = Point.new(0,0)
    @direction = Direction::Up

    ship.get_panel(position).color = Ship::Panel::WHITE
  end

  def run
    loop do
      break if brain.halted?

      panel = ship.get_panel(position)

      brain.write(panel.color)
      panel.color = brain.read

      case turn = brain.read
      when 0 then @direction = direction.left
      when 1 then @direction = direction.right
      else
        fail "Unknown turn: #{turn}"
      end

      @position = direction.move(position)
    end

    ship.panels.count
  end

  private

  attr_reader :brain
end

