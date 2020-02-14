$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "ship/robot"
require "ship/robot/brain"

program = File.read("../input/day11.txt")

brain = Ship::Robot::Brain.new(program)
robot = Ship::Robot.new(brain)

puts "Painting ship's hull..."

painted_panels = robot.run
puts "Number of panels painted by robot (part 1): #{painted_panels}"
