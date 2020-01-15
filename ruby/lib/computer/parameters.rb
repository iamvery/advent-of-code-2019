require "computer/parameters/immediate"
require "computer/parameters/positional"

class Computer
  Params = Parameters

  module Parameters
    def self.Immediate(*args)
      Parameters::Immediate.new(*args)
    end

    def self.Positional(*args)
      Parameters::Positional.new(*args)
    end
  end
end
