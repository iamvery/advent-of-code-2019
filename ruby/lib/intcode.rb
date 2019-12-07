module Intcode
  def self.call(program)
    integers = program.split(",").map { |i| Integer(i) }
    run(integers)
    integers.join(",")
  end

  def self.run(integers, position = 0)
    opcode = integers[position]
    first_input_position = integers[position+1]
    second_input_position = integers[position+2]
    output_position = integers[position+3]

    integers[output_position] = case opcode
    when 1
      integers[first_input_position] + integers[second_input_position]
    when 2
      integers[first_input_position] * integers[second_input_position]
    when 99
      return
    else
      fail "Unknown opcode: #{opcode}"
    end

    run(integers, position + 4)
  end
end
