module Computer
  module Operations
    Multiplication = Struct.new(:left_input, :right_input, :output) do
      def call(memory)
        result = left_input.read(memory) * right_input.read(memory)
        output.write(result, memory)
      end
    end
  end
end
