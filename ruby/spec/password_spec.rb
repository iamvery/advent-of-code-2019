require "password"

RSpec.describe Password do
  describe "the criteria" do
    it "must be a six-digit number" do
      expect(described_class.valid?(11111)).to be(false)
    end

    it "must have two adjacent digits that are the same" do
      expect(described_class.valid?(123456)).to be(false)
    end

    it "must contain only increasing digits from left the right" do
      pending
      expect(described_class.valid?(111110)).to be(false)
    end

    it "validates examples" do
      pending
      expect(described_class.valid?(111111)).to be(true)
      expect(described_class.valid?(223450)).to be(false)
      expect(described_class.valid?(123789)).to be(false)
    end
  end
end
