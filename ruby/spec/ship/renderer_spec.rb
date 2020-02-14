require "stringio"
require "ship/renderer"
require "ship"
require "point"

RSpec.describe Ship::Renderer do
  it "renders a visualization of the ship's hull" do
    ship = Ship.new
    ship.get_panel(Point.new(0,0)).color = Ship::Panel::WHITE
    ship.get_panel(Point.new(1,0)).color = Ship::Panel::WHITE
    ship.get_panel(Point.new(0,1)).color = Ship::Panel::WHITE
    ship.get_panel(Point.new(-1,0)).color = Ship::Panel::WHITE
    ship.get_panel(Point.new(0,-1)).color = Ship::Panel::WHITE
    ship.get_panel(Point.new(0,-2)).color = Ship::Panel::WHITE
    output = StringIO.new
    renderer = described_class.new(output)

    renderer.render(ship)

    expect(output.string).to eq <<~OUTPUT
    █░█
    ░░░
    █░█
    █░█
    OUTPUT
  end
end
