module FuelCost
  def self.call(mass:)
    (mass / 3.0).floor - 2
  end
end
