require "stringio"
require "computer"

RSpec.describe Computer do
  it "runs example programs" do
    expect(described_class.("1,0,0,0,99")).to eq("2,0,0,0,99")
    expect(described_class.("2,3,0,3,99")).to eq("2,3,0,6,99")
    expect(described_class.("2,4,4,5,99,0")).to eq("2,4,4,5,99,9801")
    expect(described_class.("1,1,1,4,99,5,6,0,99")).to eq("30,1,1,4,2,5,6,0,99")
    expect(described_class.("1002,4,3,4,33")).to eq("1002,4,3,4,99")
    expect(described_class.("1101,100,-1,4,0")).to eq("1101,100,-1,4,99")

    input = StringIO.new("123")
    output = StringIO.new
    described_class.new([3,0,4,0,99], 0, input, output).run
    expect(output.string).to eq("123\n")
  end

  it "runs conditional logic" do
    input = StringIO.new("8")
    output = StringIO.new
    described_class.new([3,9,8,9,10,9,4,9,99,-1,8], 0, input, output).run
    expect(output.string).to eq("1\n")
    input = StringIO.new("1")
    output = StringIO.new
    described_class.new([3,9,8,9,10,9,4,9,99,-1,8], 0, input, output).run
    expect(output.string).to eq("0\n")

    input = StringIO.new("7")
    output = StringIO.new
    described_class.new([3,9,7,9,10,9,4,9,99,-1,8], 0, input, output).run
    expect(output.string).to eq("1\n")
    input = StringIO.new("9")
    output = StringIO.new
    described_class.new([3,9,7,9,10,9,4,9,99,-1,8], 0, input, output).run
    expect(output.string).to eq("0\n")

    input = StringIO.new("8")
    output = StringIO.new
    described_class.new([3,3,1108,-1,8,3,4,3,99], 0, input, output).run
    expect(output.string).to eq("1\n")

    input = StringIO.new("7")
    output = StringIO.new
    described_class.new([3,3,1107,-1,8,3,4,3,99], 0, input, output).run
    expect(output.string).to eq("1\n")
  end
end
