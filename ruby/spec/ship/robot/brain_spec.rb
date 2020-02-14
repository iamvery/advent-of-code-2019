require "ship/robot/brain"

RSpec.describe Ship::Robot::Brain do
  describe "#read" do
    it "reads an output" do
      brain = described_class.new("4,0,99")
      value = brain.read
      expect(value).to eq(4)
    end
  end

  describe "#write" do
    it "writes an input" do
      brain = described_class.new("3,0,4,0,99")
      brain.write(123)
      value = brain.read
      expect(value).to eq(123)
    end
  end

  describe "#halted?" do
    it "returns false when brain is running" do
      brain = described_class.new("3,0,99")
      expect(brain.halted?).to be(false)
    end

    it "returns true when brain is not accepting anymore inputs or producing outputs" do
      brain = described_class.new("99")
      expect(brain.halted?).to be(true)
    end
  end
end
