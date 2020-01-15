require "computer/parameters"
require "computer/operations"

class Computer
  def self.call(program)
    memory = program.split(",").map { |i| Integer(i) }
    result = new(memory).run
    result.join(",")
  end

  attr_reader :memory, :position

  def initialize(memory, position = 0, input = $stdin, output = $stdout)
    @memory = memory
    @position = position
    @input = input
    @output = output
  end

  def run
    case opcode
    when [1], [1,0]
      first_input, second_input, output = get_parameters(count: 3)
      @memory = Operations::Addition.new(first_input, second_input, output).call(memory)
      @position += 4
    when [2], [2,0]
      first_input, second_input, output = get_parameters(count: 3)
      @memory = Operations::Multiplication.new(first_input, second_input, output).call(memory)
      @position += 4
    when [3], [3,0]
      position, = get_parameters(count: 1)
      @memory = Operations::Input.new(position, @input).call(memory)
      @position += 2
    when [4], [4,0]
      position, = get_parameters(count: 1)
      Operations::Output.new(position, @output).call(memory)
      @position += 2
    when [7], [7,0]
      left, right, output = get_parameters(count: 3)
      @memory = Operations::LessThan.new(left, right, output).call(memory)
      @position += 4
    when [8], [8,0]
      left, right, output = get_parameters(count: 3)
      @memory = Operations::Equals.new(left, right, output).call(memory)
      @position += 4
    when [9,9]
      return memory
    else
      fail "Unknown opcode: #{opcode}"
    end

    run
  end

  private

  def opcode
    instruction.digits.take(2)
  end

  def get_parameters(count:)
    parameter_memory = memory[position+1..position+count]
    parameter_memory.zip(parameter_modes).map { |(mem, mode)|
      case mode
      when 1 then Parameters::Immediate.new(mem)
      else
        Parameters::Positional.new(mem)
      end
    }
  end

  def parameter_modes
    Array(instruction.digits[2..])
  end

  def instruction
    memory[position]
  end
end
