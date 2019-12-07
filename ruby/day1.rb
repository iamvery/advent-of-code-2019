require "./lib/fuel_cost"

lines = File.read("../input/day1.txt").split("\n")
masses = lines.map { |line| Integer(line) }

total_fuel_cost = masses
  .map { |mass| FuelCost.(mass: mass) }
  .reduce(:+)

puts "(part 1) Total fuel cost: #{total_fuel_cost}"

total_fuel_cost = masses
  .map { |mass| FuelCost.calculate(mass: mass) }
  .reduce(:+)

puts "(part 2) Total fuel cost: #{total_fuel_cost}"
