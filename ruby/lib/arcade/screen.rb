# frozen_string_literal: true

module Arcade
  class Screen
    RESOLUTION = [
      WIDTH = 44,
      HEIGHT = 20,
    ].freeze

    TILES = [
      EMPTY = " ",
      WALL = "║",
      BLOCK = "¤",
      HORIZONTAL_PADDLE = "—",
      BALL = "•",
    ].freeze

    def initialize(output = $stdout)
      @output = output
    end

    def render(pixels)
      output.print("┌")
      output.print("─" * WIDTH)
      output.puts("┐")

      HEIGHT.times do |y|
        output.print "│"
        WIDTH.times do |x|
          tile = pixels.fetch(Point.new(x,y), 0)
          output.print TILES[tile]
        end
        output.puts "│"
      end

      output.print("└")
      output.print("─" * WIDTH)
      output.puts("┘")
    end

    private

    attr_reader :output
  end
end
