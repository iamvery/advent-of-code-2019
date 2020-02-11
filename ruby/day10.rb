$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "space/asteroid_field"

data = File.read("../input/day10.txt")

point, total = Space::AsteroidField.parse(data).ideal

puts "Ideal location for base: #{point}"
puts "with total visibility (part 1): #{total}"
