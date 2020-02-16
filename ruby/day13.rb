$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "arcade/cabinet"
require "pry"

game = File.read("../input/day13.txt")

Aracde::Cabinet.new(game).run(stats: true)

puts "Note: The number of 'block' tiles displayed (part 1)"
