RSpec.describe "day 1, part 1" do
  describe "fuel calculations" do
    it "calculates fuel for examples" do
      expect(fuel_cost(mass: 12)).to eq(2)
      expect(fuel_cost(mass: 14)).to eq(2)
      expect(fuel_cost(mass: 1969)).to eq(654)
      expect(fuel_cost(mass: 100756)).to eq(33583)
    end
  end

  def fuel_cost(mass:)
    (mass / 3.0).floor - 2
  end
end
