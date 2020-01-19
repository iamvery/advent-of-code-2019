require "space/body"

module Space
  Orbits = Struct.new(:bodies) do
    def self.process(data)
      data = data.split.map { |orbit| orbit.split(")") }
      bodies = Hash.new { |h, k|
        body = Space::Body.new(k)
        h.store(k, body)
      }
      new data.reduce(bodies) { |bodies, (orbited_id, orbiting_id)|
        orbited_body = bodies[orbited_id]
        orbiting_body = bodies[orbiting_id]
        orbiting_body.body = orbited_body
        bodies.tap { |b| b.store(orbiting_id, orbiting_body) }
      }
    end

    def indirect_orbits
      bodies.values.map(&:indirect_orbits).reduce(&:+)
    end
  end
end
