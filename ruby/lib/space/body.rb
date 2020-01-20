module Space
  Body = Struct.new(:id, :body) do
    def indirect_orbits
      count - 1
    end

    def each(&b)
      yield(self)
      body.each(&b) if body
    end
  end
end
