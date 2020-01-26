$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "space/image_format"

image_data = File.read("../input/day8.txt").chomp
image = Space::ImageFormat.parse(image_data, width: 25, height: 6)

puts "Image checksum (part 1): #{image.checksum}"
