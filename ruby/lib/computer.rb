require "computer/parameters"
require "computer/operations"

module Computer
  def self.call(program)
    memory = program.split(",").map { |i| Integer(i) }
    result = run(memory)
    result.join(",")
  end

  def self.run(memory, position = 0)
    instruction = memory[position]
    digits = instruction.digits
    opcode = digits.take(2)
    parameter_modes = Array(digits[2..])

    case opcode
    when [1], [1,0]
      parameter_memory = memory[position+1..position+3]
      parameters = parameter_memory.zip(parameter_modes).map { |(mem, mode)|
        case mode
        when 1 then Parameters::Immediate.new(mem)
        else
          Parameters::Positional.new(mem)
        end
      }
      first_input, second_input, output = parameters
      next_memory = Operations::Addition.new(first_input, second_input, output).call(memory)
      run(next_memory, position + 4)
    when [2], [2,0]
      parameter_memory = memory[position+1..position+3]
      parameters = parameter_memory.zip(parameter_modes).map { |(mem, mode)|
        case mode
        when 1 then Parameters::Immediate.new(mem)
        else
          Parameters::Positional.new(mem)
        end
      }
      first_input, second_input, output = parameters
      next_memory = Operations::Multiplication.new(first_input, second_input, output).call(memory)
      run(next_memory, position + 4)
    when [9,9]
      return memory
    else
      fail "Unknown opcode: #{opcode}"
    end
  end
end
