module Intcode
  def self.call(program)
    memory = program.split(",").map { |i| Integer(i) }
    result = run(memory)
    result.join(",")
  end

  def self.run(memory, position = 0)
    opcode = memory[position]
    first_input_position = memory[position+1]
    second_input_position = memory[position+2]
    output_position = memory[position+3]

    memory[output_position] = case opcode
    when 1
      memory[first_input_position] + memory[second_input_position]
    when 2
      memory[first_input_position] * memory[second_input_position]
    when 99
      return memory
    else
      fail "Unknown opcode: #{opcode}"
    end

    run(memory, position + 4)
  end
end
