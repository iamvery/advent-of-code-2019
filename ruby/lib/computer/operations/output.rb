module Computer
  module Operations
    class Output
      def initialize(position, output = $stdout)
        @position = position
        @output = output
      end

      def call(memory)
        output.puts position.read(memory)
      end

      private

      attr_reader :position, :output
    end
  end
end
