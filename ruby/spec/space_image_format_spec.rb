#require "space_image_format"

SpaceImageFormat = Struct.new(:layers) do
  def self.parse(data, width:, height:)
    pixels = data.split("").map(&method(:Integer))
    layers = pixels.each_slice(width * height)
    new(layers.to_a)
  end

  def checksum
    counts = layers.map { |layer|
      layer.each_with_object(Hash.new(0)) { |p,t| t[p] += 1 }
    }
    count = counts.min { |c| c[0] }
    count[1] * count[2]
  end
end

RSpec.describe SpaceImageFormat do
  describe ".parse" do
    it "parses image data into layers" do
      image = described_class.parse("123456789012", width: 3, height: 2)
      expect(image.layers.count).to eq(2)
      expect(image.layers.first).to eq([
        1,2,3,
        4,5,6,
      ])
      expect(image.layers.last).to eq([
        7,8,9,
        0,1,2,
      ])
    end
  end

  describe "#checksum" do
    it "multiplies the number 1s by the number of 2s in the layer with the fewest 0s" do
      image = described_class.parse("111222012234", width: 3, height: 2)
      expect(image.checksum).to eq(9)
    end
  end
end
