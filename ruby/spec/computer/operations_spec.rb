require "computer/operations/addition"
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
end
