require "./lib/intcode"

input_program = File.read("../input/day2.txt")
codes = input_program.split(",").map(&method(:Integer))
codes[1] = 12
codes[2] = 2

final_state = Intcode.run(codes)
output_program = final_state.join(",")

puts "(part 1) Final program state: #{output_program}"
