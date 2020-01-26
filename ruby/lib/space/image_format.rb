module Space
  class ImageFormat < Struct.new(:layers)
    BLACK = 0
    WHITE = 1
    TRANSPARENT = 2

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

    def render
      layers.reduce(&:zip).map(&:flatten).map { |pixels|
        pixels.find { |pixel| pixel != TRANSPARENT }
      }
    end
  end
end
