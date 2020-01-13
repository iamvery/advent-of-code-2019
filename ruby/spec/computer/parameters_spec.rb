require "computer/parameters/immediate"
require "computer/parameters/positional"

RSpec.describe Computer::Parameters do
  describe Computer::Parameters::Positional do
    describe "#read" do
      it "returns value at initialized position" do
        memory = [first = 1, second = 2, third = 3]
        position = 1
        parameter = described_class.new(position)
        value = parameter.read(memory)
        expect(value).to eq(second)
      end
    end

    describe "#write" do
      it "returns memory updated at initialized position" do
        memory = [1,2,3]
        parameter = described_class.new(1)
        new_memory = parameter.write(4, memory)
        expect(new_memory).to eq([1,4,3])
      end
    end
  end

  describe Computer::Parameters::Immediate do
    describe "#read" do
      it "returns value it is initialized with" do
        memory = []
        value = 1
        parameter = described_class.new(value)
        value = parameter.read(memory)
        expect(value).to eq(value)
      end
    end

    describe "#write" do
      it "is not implemented" do
        parameter = described_class.new(1)
        expect { parameter.write(0, []) }.to raise_error(NotImplementedError)
      end
    end
  end
end
