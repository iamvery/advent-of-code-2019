module Space
  Body = Struct.new(:id, :body) do
    def indirect_orbits
      if body
        1 + body.indirect_orbits
      else
        0
      end
    end

    class Bodies
      include Enumerable
      attr_reader :body

      def initialize(body)
        @body = body
      end

      def each(&b)
        if body
          yield(body)
          body.bodies.each(&b)
        end
      end
    end

    def bodies
      Bodies.new(body)
    end
  end
end
