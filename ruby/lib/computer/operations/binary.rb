class Computer
  module Operations
    Binary = Struct.new(:left, :right, :output) do
      def call(memory)
        if yield left.read(memory), right.read(memory)
          output.write(1, memory)
        else
          output.write(0, memory)
        end
      end
    end
  end
end
