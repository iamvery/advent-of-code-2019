$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "space/asteroid_field"

data = File.read("../input/day10.txt")

field = Space::AsteroidField.parse(data)
point, total = field.ideal

puts "Ideal location for base: #{point}"
puts "with total visibility (part 1): #{total}"

vaporized = field.vaporize
asteroid = vaporized[199]
value = asteroid.point.x * 100 + asteroid.point.y
puts "Value for winning bet (part 2): #{value}"
