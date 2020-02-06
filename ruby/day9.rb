$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "computer"

input_program = File.read("../input/day9.txt")

puts "Enter mode ('1' for test mode):"
Computer.(input_program)
