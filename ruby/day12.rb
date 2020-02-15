$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "space/simulation"

data = File.read("../input/day12.txt")

simulation = Space::Simulation.parse(data)
simulation.step(1000)

puts "Total energy in simulation after 1000 steps (part 1): #{simulation.total_energy}"
