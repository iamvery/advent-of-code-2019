require "spec_helper"
require "space/asteroid_field"

RSpec.describe Space::AsteroidField do
  it "works" do
    data = <<~DATA
      .#..#
      .....
      #####
      ....#
      ...##
    DATA

    field = described_class.parse(data)
    point, total = field.ideal

    expect(point).to eq(Point.new(3,4))
    expect(total).to eq(8)
  end
end
