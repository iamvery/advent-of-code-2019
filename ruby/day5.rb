$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "computer"

input_program = File.read("../input/day5.txt")

puts "Enter user ID:"
Computer.(input_program)
