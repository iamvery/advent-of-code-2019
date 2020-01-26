#require "space_image_format"

SpaceImageFormat = Struct.new(:layers) do
  def self.parse(data, width:, height:)
    pixels = data.split("").map(&method(:Integer))
    layers = pixels.each_slice(width).each_slice(height)
    new(layers.to_a)
  end
end

RSpec.describe SpaceImageFormat do
  describe ".parse" do
    it "parses image data into layers" do
      image = described_class.parse("123456789012", width: 3, height: 2)
      expect(image.layers.count).to eq(2)
      expect(image.layers.first).to eq([
        [1,2,3],
        [4,5,6],
      ])
      expect(image.layers.last).to eq([
        [7,8,9],
        [0,1,2],
      ])
    end
  end
end
