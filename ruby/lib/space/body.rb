module Space
  Body = Struct.new(:id, :body) do
    def indirect_orbits
      if body
        1 + body.indirect_orbits
      else
        0
      end
    end
  end
end
