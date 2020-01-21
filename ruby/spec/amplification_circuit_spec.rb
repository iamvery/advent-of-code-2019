require "amplification_circuit"

RSpec.describe AmplificationCircuit do
  it "works with provided examples" do
    program = "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0"
    phase_setting_sequence = [4,3,2,1,0]
    thruster_signal = described_class.(program, phase_setting_sequence)
    expect(thruster_signal).to eq(43210)
    expect(described_class.max(program)).to eq([phase_setting_sequence, 43210])

    program = "3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0"
    phase_setting_sequence = [0,1,2,3,4]
    thruster_signal = described_class.(program, phase_setting_sequence)
    expect(thruster_signal).to eq(54321)
    expect(described_class.max(program)).to eq([phase_setting_sequence, 54321])

    program = "3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0"
    phase_setting_sequence = [1,0,4,3,2]
    thruster_signal = described_class.(program, phase_setting_sequence)
    expect(thruster_signal).to eq(65210)
    expect(described_class.max(program)).to eq([phase_setting_sequence, 65210])
  end
end
