# frozen_string_literal: true

module Arcade
  class Screen
    TILES = [
      EMPTY = " ",
      WALL = "║",
      BLOCK = "¤",
      HORIZONTAL_PADDLE = "—",
      BALL = "•",
    ].freeze

    def initialize(output)
      @output = output
    end

    def render(pixels)
      x_range = 0..pixels.keys.map(&:x).max
      y_range = 0..pixels.keys.map(&:y).max

      output.print("┌")
      output.print("─" * x_range.count)
      output.puts("┐")

      y_range.each do |y|
        output.print "│"
        x_range.each do |x|
          tile = pixels.fetch(Point.new(x,y), 0)
          output.print TILES[tile]
        end
        output.puts "│"
      end

      output.print("└")
      output.print("─" * x_range.count)
      output.puts("┘")

    end

    private

    attr_reader :output
  end
end
