require "logger"
require "timeout"
require "curses"
require "computer"
require "point"
require "arcade/screen"

module Aracde
  class Cabinet
    def initialize(program)
      @logger = Logger.new("tmp/arcade.log")
      @program = program
      @screen = Arcade::Screen.new
      @ball_location = Point.new(0,0)
      @paddle_location = Point.new(0,0)
    end

    def run(auto: false)
      Curses.stdscr.keypad(true)
      ip_r, ip_w = IO.pipe
      op_r, op_w = IO.pipe
      Thread.new { Computer.(program, ip_r, op_w) }
      Thread.new {
        loop do
          if auto
            ip_w.puts(@ball_location.x <=> @paddle_location.x)
            sleep 0.25
          else
            case key = Curses.getch
            when Curses::Key::LEFT
              ip_w.puts(-1)
            when Curses::Key::RIGHT
              ip_w.puts(1)
            when Curses::Key::DOWN
              ip_w.puts(0)
            end
          end
        end
      }
      loop do
        x = Integer(op_r.gets)
        y = Integer(op_r.gets)

        if x == -1
          score = Integer(op_r.gets)
          logger.info("Score: #{score}")
          Curses.setpos(0,0)
          Curses.addstr("Score: #{score}")
        else
          point = Point.new(x,y)
          tile = Integer(op_r.gets)
          screen.set(point, tile)

          case tile
          when Arcade::Screen::TILES.index(Arcade::Screen::BALL)
            logger.info("Ball at #{point}")
            @ball_location = point
          when Arcade::Screen::TILES.index(Arcade::Screen::HORIZONTAL_PADDLE)
            logger.info("Paddle at #{point}")
            @paddle_location = point
          end
        end
      end
    end

    private

    attr_reader :logger, :program, :screen
  end
end
