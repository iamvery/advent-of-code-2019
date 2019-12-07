module FuelCost
  def self.call(mass:)
    (mass / 3.0).floor - 2
  end

  def self.calculate(mass:)
    cost = call(mass: mass)
    return 0 if cost.negative?
    cost + calculate(mass: cost)
  end
end
