$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "computer"

input_program = File.read("../input/day2.txt")
codes = input_program.split(",").map(&method(:Integer))

input_memory = codes.dup
input_memory[1] = 12
input_memory[2] = 2

output_memory = Computer.new(input_memory).run
output_program = output_memory.join(",")

puts "(part 1) Final program state: #{output_program}"

expected_output = 19690720

values = (0..99).to_a
noun, verb = values.product(values).find do |(noun, verb)|
  input_memory = codes.dup
  input_memory[1] = noun
  input_memory[2] = verb
  output_memory = Computer.new(input_memory).run
  output_memory.first == expected_output
end

answer = 100 * noun + verb

puts "(part 2) 100 * noun + verb = #{answer}"
