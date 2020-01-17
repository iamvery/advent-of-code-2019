require "space/body"

module Space
  module Orbits
    def self.process(data)
      data = data.split.map { |orbit| orbit.split(")") }
      data.reduce("COM" => Space::Body.new) { |bodies, (orbited_id, orbiting_id)|
        orbited_body = bodies.fetch(orbited_id)
        orbiting_body = Space::Body.new(orbited_body)
        bodies.tap { |b| b.store(orbiting_id, orbiting_body) }
      }
    end
  end
end
