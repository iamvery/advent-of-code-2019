require "computer/parameters"
require "computer/operations"

class Computer
  def self.call(program, input = $stdin, output = $stdout)
    memory = program.split(",").map { |i| Integer(i) }
    result = new(memory, input, output).run
    result.join(",")
  end

  attr_reader :memory, :position

  def initialize(memory, input, output)
    @memory = memory
    @position = 0
    @input = input
    @output = output
  end

  def run
    case opcode
    when 1
      first_input, second_input, output = get_parameters(count: 3)
      @memory = Op::Addition.new(first_input, second_input, output).call(memory)
      @position += 4
    when 2
      first_input, second_input, output = get_parameters(count: 3)
      @memory = Op::Multiplication.new(first_input, second_input, output).call(memory)
      @position += 4
    when 3
      position, = get_parameters(count: 1)
      @memory = Op::Input.new(position, @input).call(memory)
      @position += 2
    when 4
      position, = get_parameters(count: 1)
      Op::Output.new(position, @output).call(memory)
      @position += 2
    when 5
      operand, result = get_parameters(count: 2)
      new_position = Op::Unary
        .new(operand, result)
        .call(memory) { |v| v != 0 }
      @position = new_position || @position + 3
    when 6
      operand, result = get_parameters(count: 2)
      new_position = Op::Unary
        .new(operand, result)
        .call(memory) { |v| v == 0 }
      @position = new_position || @position + 3
    when 7
      left, right, output = get_parameters(count: 3)
      @memory = Op::Binary
        .new(left, right, output)
        .call(memory) { |l, r| l < r }
      @position += 4
    when 8
      left, right, output = get_parameters(count: 3)
      @memory = Op::Binary
        .new(left, right, output)
        .call(memory) { |l, r| l == r }
      @position += 4
    when 99
      return memory
    else
      fail "Unknown opcode: #{opcode}"
    end

    run
  end

  private

  def opcode
    tens = (0..).lazy.map { |n| 10**n } # [1, 10, 100, ...]
    digits = instruction.digits.take(2)
    digits.zip(tens).map { |(n,b)| n*b }.sum # [3, 20, 100] -> 123
  end

  def get_parameters(count:)
    parameter_memory = memory[position+1..position+count]
    parameter_memory.zip(parameter_modes).map { |(mem, mode)|
      case mode
      when 1 then Params::Immediate(mem)
      else
        Params::Positional(mem)
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
