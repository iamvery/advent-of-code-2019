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

    def minimum_transfers(first_id, second_id)
      first = bodies.fetch("YOU")
      second = bodies.fetch("SAN")
      common = first.bodies.find { |a|
        second.bodies.find { |b| b.id == a.id }
      }
      first_distance = first.indirect_orbits - common.indirect_orbits - 1
      second_distance = second.indirect_orbits - common.indirect_orbits - 1
      first_distance + second_distance
    end
  end
end
