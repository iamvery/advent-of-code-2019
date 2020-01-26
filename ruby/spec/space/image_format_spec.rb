require "space/image_format"

RSpec.describe Space::ImageFormat do
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
      image = described_class.parse("012234111222", width: 3, height: 2)
      expect(image.checksum).to eq(9)
    end
  end
end
