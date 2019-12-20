$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "wiring"

input = File.read("../input/day3.txt")
path1, path2 = input.split("\n")
puts "path1:", path1
puts "path2:", path2

wiring = Wiring.new(path1, path2)

puts "(part 1) Distance: #{wiring.distance}"
