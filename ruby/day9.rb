$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "computer"

input_program = File.read("../input/day9.txt")

puts "Enter mode ('1' for test mode [part 1], '2' for sensor boost mode [part 2]):"
Computer.(input_program)
