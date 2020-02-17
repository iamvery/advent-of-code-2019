require "arcade/screen"
require "point"

RSpec.describe Arcade::Screen do
  describe "#set" do
    it "sets the pixel value at the point and draws the screen" do
      output = StringIO.new
      screen = described_class.new(output)

      screen.set(Point.new(1,2), 3)
      screen.set(Point.new(6,5), 4)

      expect(output.string).to eq <<~DISPLAY
       ┌────────────────────────────────────────────┐
       │                                            │
       │                                            │
       │ —                                          │
       │                                            │
       │                                            │
       │      •                                     │
       │                                            │
       │                                            │
       │                                            │
       │                                            │
       │                                            │
       │                                            │
       │                                            │
       │                                            │
       │                                            │
       │                                            │
       │                                            │
       │                                            │
       │                                            │
       │                                            │
       └────────────────────────────────────────────┘
      DISPLAY
    end
  end
end
