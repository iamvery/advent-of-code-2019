module Intcode
  def self.call(program)
    integers = program.split(",").map { |i| Integer(i) }
    run(integers)
    integers.join(",")
  end

  def self.run(codes, position = 0)
    opcode = codes[position]
    first_input_position = codes[position+1]
    second_input_position = codes[position+2]
    output_position = codes[position+3]

    codes[output_position] = case opcode
    when 1
      codes[first_input_position] + codes[second_input_position]
    when 2
      codes[first_input_position] * codes[second_input_position]
    when 99
      return
    else
      fail "Unknown opcode: #{opcode}"
    end

    run(codes, position + 4)
  end
end
