require "stringio"
require "computer"

module AmplificationCircuit
  def self.max(program)
    (0..4).to_a
      .permutation(5)
      .map { |sequence| [sequence, call(program, sequence)] }
      .max { |(_,a),(_,b)| a <=> b }
  end

  def self.call(program, phase_setting_sequence)
    phase_setting_sequence.reduce(0) do |input_signal, phase_setting|
      input = StringIO.new
      input.puts(phase_setting)
      input.puts(input_signal)
      input.rewind
      output = StringIO.new
      Computer.call(program.dup, input, output)
      Integer(output.string)
    end
  end
end

