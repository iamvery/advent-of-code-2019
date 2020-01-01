require "password"

RSpec.describe Password do
  describe "the criteria" do
    it "must be a six-digit number" do
      expect(described_class.valid?(11111)).to be(false)
    end

    it "must have two adjacent digits that are the same" do
      expect(described_class.valid?(123456)).to be(false)
    end

    it "must have at least one pair of adjacent digits that are the same" do
      expect(described_class.valid?(123334)).to be(false)
      expect(described_class.valid?(111233)).to be(true)
      expect(described_class.valid?(111123)).to be(false)
    end

    it "must contain only increasing digits from left the right" do
      expect(described_class.valid?(111110)).to be(false)
    end

    it "validates examples" do
      expect(described_class.valid?(111111)).to be(false)
      expect(described_class.valid?(223450)).to be(false)
      expect(described_class.valid?(123789)).to be(false)
      expect(described_class.valid?(112233)).to be(true)
      expect(described_class.valid?(123444)).to be(false)
      expect(described_class.valid?(111122)).to be(true)
    end
  end
end
