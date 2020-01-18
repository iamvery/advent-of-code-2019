$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "space/orbits"

orbit_data = File.read("../input/day6.txt")

bodies = Space::Orbits.process(orbit_data)
total_orbits = bodies.values.map(&:indirect_orbits).reduce(&:+)

puts "Total number of orbits (part 1): #{total_orbits}"
