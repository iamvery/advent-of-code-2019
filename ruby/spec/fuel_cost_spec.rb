require "fuel_cost"

RSpec.describe FuelCost do
  describe "fuel calculations" do
    it "calculates fuel for examples" do
      expect(described_class.(mass: 12)).to eq(2)
      expect(described_class.(mass: 14)).to eq(2)
      expect(described_class.(mass: 1969)).to eq(654)
      expect(described_class.(mass: 100756)).to eq(33583)
    end
  end
end
