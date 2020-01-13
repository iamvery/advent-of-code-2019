module Computer
  module Operations
    class Input
      def initialize(position, input = $stdin)
        @position = position
        @input = input
      end

      def call(memory)
        value = Integer(input.gets)
        position.write(value, memory)
      end

      private

      attr_reader :position, :input
    end
  end
end
