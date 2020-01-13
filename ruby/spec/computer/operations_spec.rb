require "stringio"
require "computer/operations/addition"
require "computer/operations/multiplication"
require "computer/operations/input"
require "computer/operations/output"
require "computer/parameters/immediate"
require "computer/parameters/positional"

RSpec.describe Computer::Operations do
  describe Computer::Operations::Addition do
    it "adds two parameters and stores the result" do
      first_input = Computer::Parameters::Positional.new(0)
      second_input = Computer::Parameters::Immediate.new(2)
      output = Computer::Parameters::Positional.new(0)
      memory = [1]

      operation = described_class.new(first_input, second_input, output)
      new_memory = operation.(memory)

      expect(new_memory).to eq([3])
    end
  end

  describe Computer::Operations::Multiplication do
    it "multiplies two parameters and stores the result" do
      first_input = Computer::Parameters::Positional.new(0)
      second_input = Computer::Parameters::Immediate.new(2)
      output = Computer::Parameters::Positional.new(0)
      memory = [3]

      operation = described_class.new(first_input, second_input, output)
      new_memory = operation.(memory)

      expect(new_memory).to eq([6])
    end
  end

  describe Computer::Operations::Input do
    it "writes input value to position" do
      position = Computer::Parameters::Positional.new(0)
      memory = []
      input = StringIO.new("1")

      operation = described_class.new(position, input)
      new_memory = operation.(memory)

      expect(new_memory).to eq([1])
    end
  end

  describe Computer::Operations::Output do
    it "outputs value at position" do
      position = Computer::Parameters::Positional.new(0)
      memory = [123]
      output = StringIO.new

      operation = described_class.new(position, output)
      operation.(memory)

      expect(output.string).to eq("123\n")
    end
  end
end
