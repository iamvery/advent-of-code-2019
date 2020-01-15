class Computer
  module Operations
    Unary = Struct.new(:operand, :result) do
      def call(memory)
        result.read(memory) unless operand.read(memory) == 0
      end
    end
  end
end
