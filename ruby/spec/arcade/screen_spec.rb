require "arcade/screen"
require "point"

RSpec.describe Arcade::Screen do
  describe "#render" do
    it "renders pixels to output" do
      output = StringIO.new
      screen = described_class.new(output)
      data = {
        Point.new(1,2) => 3,
        Point.new(6,5) => 4,
      }

      screen.render(data)

      expect(output.string).to eq <<~DISPLAY
       ┌───────┐
       │       │
       │       │
       │ —     │
       │       │
       │       │
       │      •│
       └───────┘
      DISPLAY
    end
  end
end
