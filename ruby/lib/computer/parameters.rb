require "computer/parameters/immediate"
require "computer/parameters/positional"

class Computer
  P = Params = Parameters

  module Parameters
    def self.Immediate(*args)
      Parameters::Immediate.new(*args)
    end

    def self.Positional(*args)
      Parameters::Positional.new(*args)
    end

    class << self
      alias I Immediate
      alias P Positional
    end
  end
end
