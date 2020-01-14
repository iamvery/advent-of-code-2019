class Computer
  module Parameters
    Positional = Struct.new(:position) do
      def read(memory)
        memory[position]
      end

      def write(value, memory)
        [*memory[0...position], value, *memory[position+1..-1]]
      end
    end
  end
end
