module Space
  Body = Struct.new(:id, :body) do
    def indirect_orbits
      bodies.reduce(0) { |s| s+1 }
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
