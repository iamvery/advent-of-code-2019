require "timeout"
require "computer"
require "point"
require "arcade/screen"

module Aracde
  class Cabinet
    def initialize(program)
      @program = program
    end

    def run
      r,w = IO.pipe
      Computer.(program, $stdin, w)
      pixels = {}
      loop do
        Timeout.timeout(0.001) do
          x = Integer(r.gets)
          y = Integer(r.gets)
          tile = Integer(r.gets)
          pixels.store(Point.new(x,y), tile)
        end
      end
    rescue Timeout::Error
      Arcade::Screen.new.render(pixels)
    end

    private

    attr_reader :program
  end
end
