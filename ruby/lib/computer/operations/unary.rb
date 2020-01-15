class Computer
  module Operations
    Unary = Struct.new(:operand, :result) do
      def call(memory)
        result.read(memory) if yield operand.read(memory)
      end
    end
  end
end
