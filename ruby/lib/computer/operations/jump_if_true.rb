class Computer
  module Operations
    JumpIfTrue = Struct.new(:first_parameter, :second_parameter) do
      def call(memory)
        unless first_parameter.read(memory) == 0
          yield second_parameter.read(memory)
        end
      end
    end
  end
end
