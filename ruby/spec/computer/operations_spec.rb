require "stringio"
require "computer/operations"
require "computer/parameters"

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

  describe Computer::Operations::JumpIfTrue do
    describe "the first parameter is zero" do
      it "does not call block" do
        first_parameter = Computer::Parameters::Immediate.new(0)
        second_parameter = double
        memory = []
        operation = described_class.new(first_parameter, second_parameter)

        expect { |b| operation.(memory, &b) }.not_to yield_control
      end
    end

    describe "the first parameter is non-zero" do
      it "does calls block" do
        first_parameter = Computer::Parameters::Immediate.new(1)
        second_parameter = Computer::Parameters::Positional.new(0)
        memory = [123]
        operation = described_class.new(first_parameter, second_parameter)

        expect { |b| operation.(memory, &b) }.to yield_with_args(123)
      end
    end
  end

  describe Computer::Operations::JumpIfFalse do
    describe "the first parameter is zero" do
      it "does calls block" do
        first_parameter = Computer::Parameters::Immediate.new(0)
        second_parameter = Computer::Parameters::Positional.new(0)
        memory = [123]
        operation = described_class.new(first_parameter, second_parameter)

        expect { |b| operation.(memory, &b) }.to yield_with_args(123)
      end
    end

    describe "the first parameter is non-zero" do
      it "does not call block" do
        first_parameter = Computer::Parameters::Immediate.new(1)
        second_parameter = double
        memory = []
        operation = described_class.new(first_parameter, second_parameter)

        expect { |b| operation.(memory, &b) }.not_to yield_control
      end
    end
  end

  describe Computer::Operations::Unary do
    describe "the first parameter is non-zero" do
      it "returns the second parameter" do
        first_param = Computer::Parameters::Immediate.new(1)
        second_param = Computer::Parameters::Positional.new(0)
        memory = [123]
        operation = described_class.new(first_param, second_param)

        expect(operation.(memory)).to eq(123)
      end
    end

    describe "the first parameter is zero" do
      it "returns nil" do
        first_param = Computer::Parameters::Immediate.new(0)
        second_param = double
        memory = []
        operation = described_class.new(first_param, second_param)

        expect(operation.(memory)).to be(nil)
      end
    end
  end

  describe Computer::Operations::Binary do
    describe "condition evaluates to true" do
      it "writes '1' to the output" do
        param = Computer::Parameters::Immediate.new(1)
        output = Computer::Parameters::Positional.new(0)
        memory = []
        operation = described_class.new(param, param, output)

        result = operation.(memory) { |l, r| l == r }
        expect(result).to eq([1])
      end
    end

    describe "condition evaluates to false" do
      it "writes '0' to the output" do
        param = Computer::Parameters::Immediate.new(1)
        output = Computer::Parameters::Positional.new(0)
        memory = []
        operation = described_class.new(param, param, output)

        result = operation.(memory) { |l, r| l != r }
        expect(result).to eq([0])
      end
    end
  end
end
