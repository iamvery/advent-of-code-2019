module Direction
  module Up
    def self.left
      Left
    end

    def self.right
      Right
    end

    def self.move(point)
      point.up
    end
  end

  module Left
    def self.left
      Down
    end

    def self.right
      Up
    end

    def self.move(point)
      point.left
    end
  end

  module Down
    def self.left
      Right
    end

    def self.right
      Left
    end

    def self.move(point)
      point.down
    end
  end

  module Right
    def self.left
      Up
    end

    def self.right
      Down
    end

    def self.move(point)
      point.right
    end
  end
end
