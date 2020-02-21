# frozen_string_literal: true

require "curses"

module Arcade
  class Screen
    include Curses

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

    def initialize
      init_screen
    end

    def set(point, tile)
      setpos(point.y, point.x)
      addstr(TILES[tile])
      refresh
    end
  end
end
