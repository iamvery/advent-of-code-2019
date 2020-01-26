module Space
  ImageFormat = Struct.new(:layers) do
    def self.parse(data, width:, height:)
      pixels = data.split("").map(&method(:Integer))
      layers = pixels.each_slice(width * height)
      new(layers.to_a)
    end

    def checksum
      counts = layers.map { |layer|
        layer.each_with_object(Hash.new(0)) { |p,t| t[p] += 1 }
      }
      count = counts.min { |a,b| a[0] <=> b[0] }
      count[1] * count[2]
    end
  end
end
