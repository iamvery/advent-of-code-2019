require "computer"

RSpec.describe Computer do
  it "runs example programs" do
    expect(described_class.("1,0,0,0,99")).to eq("2,0,0,0,99")
    expect(described_class.("2,3,0,3,99")).to eq("2,3,0,6,99")
    expect(described_class.("2,4,4,5,99,0")).to eq("2,4,4,5,99,9801")
    expect(described_class.("1,1,1,4,99,5,6,0,99")).to eq("30,1,1,4,2,5,6,0,99")
    expect(described_class.("1002,4,3,4,33")).to eq("1002,4,3,4,99")
    expect(described_class.("1101,100,-1,4,0")).to eq("1101,100,-1,4,99")
  end
end
