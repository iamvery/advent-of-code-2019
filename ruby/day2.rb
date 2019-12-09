require "./lib/intcode"

input_program = File.read("../input/day2.txt")
codes = input_program.split(",").map(&method(:Integer))

input_memory = codes.dup
input_memory[1] = 12
input_memory[2] = 2

output_memory = Intcode.run(input_memory)
output_program = output_memory.join(",")

puts "(part 1) Final program state: #{output_program}"
