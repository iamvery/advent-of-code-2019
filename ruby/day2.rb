require "./lib/intcode"

program = File.read("../input/day2.txt")

final_state = Intcode.(program)

puts "(part 1) Final program state: #{final_state}"
