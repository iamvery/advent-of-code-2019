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

  it "works with fourth example" do
    field = described_class.parse <<~DATA
      .#..##.###...#######
      ##.############..##.
      .#.######.########.#
      .###.#######.####.#.
      #####.##.#.##.###.##
      ..#####..#.#########
      ####################
      #.####....###.#.#.##
      ##.#################
      #####.##.###..####..
      ..######..##.#######
      ####.##.####...##..#
      .#####..#.######.###
      ##...#.##########...
      #.##########.#######
      .####.#.###.###.#.##
      ....##.##.###..#####
      .#.#.###########.###
      #.#.#.#####.####.###
      ###.##.####.##.#..##
    DATA

    point, total = field.ideal

    expect(point).to eq(Point.new(11,13))
    expect(total).to eq(210)

    vaporized_asteroids = field.vaporize

    expect(vaporized_asteroids[0].point).to eq(Point.new(11,12))
    expect(vaporized_asteroids[1].point).to eq(Point.new(12,1))
    expect(vaporized_asteroids[2].point).to eq(Point.new(12,2))
    expect(vaporized_asteroids[9].point).to eq(Point.new(12,8))
    expect(vaporized_asteroids[19].point).to eq(Point.new(16,0))
    expect(vaporized_asteroids[49].point).to eq(Point.new(16,9))
    expect(vaporized_asteroids[99].point).to eq(Point.new(10,16))
    expect(vaporized_asteroids[198].point).to eq(Point.new(9,6))
    expect(vaporized_asteroids[199].point).to eq(Point.new(8,2))
    expect(vaporized_asteroids[200].point).to eq(Point.new(10,9))
    expect(vaporized_asteroids[298].point).to eq(Point.new(11,1))
  end
end
