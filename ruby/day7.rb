$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "amplification_circuit"

input_program = File.read("../input/day7.txt")
sequence, signal = AmplificationCircuit.max(input_program)

puts "(part 1) Ideal phase setting sequence (#{sequence.inspect}) produces the signal: #{signal}."
