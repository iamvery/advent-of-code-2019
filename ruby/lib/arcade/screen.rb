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
      @pixels = {}
    end

    def set(point, tile)
      pixels.store(point, tile)
      draw
    end

    private

    attr_reader :output, :pixels

    def draw
      output.rewind
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
  end
end
