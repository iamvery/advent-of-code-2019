$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "space/orbits"

orbit_data = File.read("../input/day6.txt")

orbits = Space::Orbits.process(orbit_data)

puts "Total number of orbits (part 1): #{orbits.indirect_orbits}"
puts "Total number of orbital transfers (part 2): #{orbits.minimum_transfers("YOU", "SAN")}"
