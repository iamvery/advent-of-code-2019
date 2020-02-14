require "computer"

class Ship
  class Robot
    class Brain
      def initialize(program)
        ip_r, @input = IO.pipe
        @output, op_w = IO.pipe
        Thread.new { Computer.(program, ip_r, op_w) }
      end

      def read
        Integer(output.gets)
      end

      def write(value)
        input.puts(value)
      end

      private

      attr_reader :input, :output
    end
  end
end
