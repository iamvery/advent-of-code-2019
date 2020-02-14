require "ship/robot"

RSpec.describe Ship::Robot do
  describe "#run" do
    it "returns the number of ship panels that were painted" do
      brain = double
      allow(brain).to receive(:write)
      allow(brain).to receive(:read).and_return(0,0, 1,0, 1,0, 0,1, 1,0, 1,0)
      allow(brain).to receive(:halted?).and_return(false, false, false, false, false, false, true)

      robot = described_class.new(brain)
      panels_painted = robot.run

      expect(panels_painted).to eq(6)
    end
  end
end
