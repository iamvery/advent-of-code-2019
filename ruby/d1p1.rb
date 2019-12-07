require "./lib/fuel_cost"

lines = File.read("../input/d1p1.txt").split("\n")
masses = lines.map { |line| Integer(line) }

total_fuel_cost = masses
  .map { |mass| FuelCost.(mass: mass) }
  .reduce(:+)

puts "Total fuel cost: #{total_fuel_cost}"
