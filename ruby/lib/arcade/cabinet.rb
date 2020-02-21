require "timeout"
require "computer"
require "point"
require "arcade/screen"

module Aracde
  class Cabinet
    def initialize(program)
      @program = program
      @screen = Arcade::Screen.new
    end

    def run
      r,w = IO.pipe
      Thread.new { Computer.(program, $stdin, w) }
      loop do
        x = Integer(op_r.gets)
        y = Integer(op_r.gets)
        point = Point.new(x,y)
        tile = Integer(op_r.gets)
        screen.set(point, tile)
      end
    end

    private

    attr_reader :program, :screen
  end
end
