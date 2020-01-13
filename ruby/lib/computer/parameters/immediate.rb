module Computer
  module Parameters
    Immediate = Struct.new(:value) do
      def read(_memory)
        value
      end

      def write(_, _)
        raise NotImplementedError
      end
    end
  end
end
