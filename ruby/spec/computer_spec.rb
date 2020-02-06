require "stringio"
require "computer"

RSpec.describe Computer do
  it "runs example programs" do
    expect(described_class.("1,0,0,0,99")).to start_with("2,0,0,0,99")
    expect(described_class.("2,3,0,3,99")).to start_with("2,3,0,6,99")
    expect(described_class.("2,4,4,5,99,0")).to start_with("2,4,4,5,99,9801")
    expect(described_class.("1,1,1,4,99,5,6,0,99")).to start_with("30,1,1,4,2,5,6,0,99")
    expect(described_class.("1002,4,3,4,33")).to start_with("1002,4,3,4,99")
    expect(described_class.("1101,100,-1,4,0")).to start_with("1101,100,-1,4,99")

    input = StringIO.new("123")
    output = StringIO.new
    described_class.new([3,0,4,0,99], input, output).run
    expect(output.string).to eq("123\n")
  end

  it "runs conditional logic" do
    input = StringIO.new("8")
    output = StringIO.new
    described_class.new([3,9,8,9,10,9,4,9,99,-1,8], input, output).run
    expect(output.string).to eq("1\n")
    input = StringIO.new("1")
    output = StringIO.new
    described_class.new([3,9,8,9,10,9,4,9,99,-1,8], input, output).run
    expect(output.string).to eq("0\n")

    input = StringIO.new("7")
    output = StringIO.new
    described_class.new([3,9,7,9,10,9,4,9,99,-1,8], input, output).run
    expect(output.string).to eq("1\n")
    input = StringIO.new("9")
    output = StringIO.new
    described_class.new([3,9,7,9,10,9,4,9,99,-1,8], input, output).run
    expect(output.string).to eq("0\n")

    input = StringIO.new("8")
    output = StringIO.new
    described_class.new([3,3,1108,-1,8,3,4,3,99], input, output).run
    expect(output.string).to eq("1\n")

    input = StringIO.new("7")
    output = StringIO.new
    described_class.new([3,3,1107,-1,8,3,4,3,99], input, output).run
    expect(output.string).to eq("1\n")
  end

  it "runs jump logic" do
    input = StringIO.new("0")
    output = StringIO.new
    described_class.new([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], input, output).run
    expect(output.string).to eq("0\n")

    input = StringIO.new("2")
    output = StringIO.new
    described_class.new([3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], input, output).run
    expect(output.string).to eq("1\n")

    input = StringIO.new("0")
    output = StringIO.new
    described_class.new([3,3,1105,-1,9,1101,0,0,12,4,12,99,1], input, output).run
    expect(output.string).to eq("0\n")

    input = StringIO.new("2")
    output = StringIO.new
    described_class.new([3,3,1105,-1,9,1101,0,0,12,4,12,99,1], input, output).run
    expect(output.string).to eq("1\n")

    input = StringIO.new("7")
    output = StringIO.new
    described_class.new([3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99], input, output).run
    expect(output.string).to eq("999\n")

    input = StringIO.new("8")
    output = StringIO.new
    described_class.new([3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99], input, output).run
    expect(output.string).to eq("1000\n")

    input = StringIO.new("9")
    output = StringIO.new
    described_class.new([3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99], input, output).run
    expect(output.string).to eq("1001\n")
  end
end
