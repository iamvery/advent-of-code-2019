$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "space_image_format"
require "pry"

image_data = File.read("../input/day8.txt").chomp
image = SpaceImageFormat.parse(image_data, width: 25, height: 6)

puts "Image checksum (part 1): #{image.checksum}"