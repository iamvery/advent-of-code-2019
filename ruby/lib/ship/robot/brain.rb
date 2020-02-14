require "timeout"
require "computer"

class Ship
  class Robot
    class Brain
      def initialize(program)
        ip_r, @input = IO.pipe
        @output, op_w = IO.pipe
        @thread = Thread.new { Computer.(program, ip_r, op_w) }
      end

      def read
        Integer(output.gets)
      end

      def write(value)
        input.puts(value)
      end

      def halted?
        Timeout.timeout(0.0001) { thread.join } rescue Timeout::Error
        !thread.alive?
      end

      private

      attr_reader :input, :output, :thread
    end
  end
end
