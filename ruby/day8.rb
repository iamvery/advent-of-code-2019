$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "space/image_format"

image_data = File.read("../input/day8.txt").chomp
image = Space::ImageFormat.parse(image_data, width: 25, height: 6)

puts "Image checksum (part 1): #{image.checksum}"

pixels = image.render
pixels.each_slice(25).each do |row|
  row.each do |pixel|
    case pixel
    when Space::ImageFormat::BLACK then print "█"
    when Space::ImageFormat::WHITE then print "░"
    when Space::ImageFormat::TRANSPARENT then print " "
    else
      fail "Unknown pixel value: #{pixel}"
    end
  end
  print "\n"
end
