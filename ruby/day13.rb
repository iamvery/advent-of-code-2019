$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "arcade/cabinet"
require "pry"

game = File.read("../input/day13.txt")

Aracde::Cabinet.new(game).run(auto: true)

puts "Note: The number of 'block' tiles displayed (part 1)"
puts "Note: The final score was observed in the logs by autoplaying the game to completion (part 2)"
