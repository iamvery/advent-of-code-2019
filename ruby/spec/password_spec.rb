RSpec.describe "Password" do
  describe "the criteria" do
    it "must be a six-digit number" do
      expect(valid?(11111)).to be(false)
    end

    it "must have two adjacent digits that are the same" do
      pending
      expect(valid?(123456)).to be(false)
    end

    it "must contain only increasing digits from left the right" do
      pending
      expect(valid?(111110)).to be(false)
    end

    it "validates examples" do
      pending
      expect(valid?(111111)).to be(true)
      expect(valid?(223450)).to be(false)
      expect(valid?(123789)).to be(false)
    end
  end

  def valid?(value)
    return false unless value.digits.count == 6
    return true
  end
end
