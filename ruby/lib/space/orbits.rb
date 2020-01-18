require "space/body"

module Space
  module Orbits
    def self.process(data)
      data = data.split.map { |orbit| orbit.split(")") }
      bodies = Hash.new { |h, k|
        body = Space::Body.new(k)
        h.store(k, body)
      }
      data.reduce(bodies) { |bodies, (orbited_id, orbiting_id)|
        orbited_body = bodies[orbited_id]
        orbiting_body = bodies[orbiting_id]
        orbiting_body.body = orbited_body
        bodies.tap { |b| b.store(orbiting_id, orbiting_body) }
      }
    end
  end
end
