require "arcade/cabinet"

RSpec.describe Aracde::Cabinet do
  describe "#run" do
    it "runs game and renders the output to the screen" do
      program = "104,1,104,2,104,3,104,6,104,5,104,4,99"
      cabinet = described_class.new(program)

      expect { cabinet.run }.to output(<<~SCREEN).to_stdout
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
      SCREEN
    end
  end
end
