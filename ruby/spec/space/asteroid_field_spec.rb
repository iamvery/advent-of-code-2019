require "spec_helper"
require "space/asteroid_field"

RSpec.describe Space::AsteroidField do
  it "works with first example" do
    field = described_class.parse <<~DATA
      .#..#
      .....
      #####
      ....#
      ...##
    DATA

    point, total = field.ideal

    expect(point).to eq(Point.new(3,4))
    expect(total).to eq(8)
  end

  it "works with second example" do
    field = described_class.parse <<~DATA
      ......#.#.
      #..#.#....
      ..#######.
      .#.#.###..
      .#..#.....
      ..#....#.#
      #..#....#.
      .##.#..###
      ##...#..#.
      .#....####
    DATA

    point, total = field.ideal

    expect(point).to eq(Point.new(5,8))
    expect(total).to eq(33)
  end

  it "works with third example" do
    field = described_class.parse <<~DATA
      #.#...#.#.
      .###....#.
      .#....#...
      ##.#.#.#.#
      ....#.#.#.
      .##..###.#
      ..#...##..
      ..##....##
      ......#...
      .####.###.
    DATA

    point, total = field.ideal

    expect(point).to eq(Point.new(1,2))
    expect(total).to eq(35)

    field = described_class.parse <<~DATA
      .#..#..###
      ####.###.#
      ....###.#.
      ..###.##.#
      ##.##.#.#.
      ....###..#
      ..#.#..#.#
      #..#.#.###
      .##...##.#
      .....#.#..
    DATA

    point, total = field.ideal

    expect(point).to eq(Point.new(6,3))
    expect(total).to eq(41)
  end
end
