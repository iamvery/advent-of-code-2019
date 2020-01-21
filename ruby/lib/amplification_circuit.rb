require "stringio"
require "computer"

module AmplificationCircuit
  def self.max(program_memory)
    (0..4).to_a
      .permutation(5)
      .map { |sequence| [sequence, call(program_memory, sequence)] }
      .max { |(_,a),(_,b)| a <=> b }
  end

  def self.call(program_memory, phase_setting_sequence)
    phase_setting_sequence.reduce(0) do |input_signal, phase_setting|
      input = StringIO.new
      input.puts(phase_setting)
      input.puts(input_signal)
      input.rewind
      output = StringIO.new
      Computer.new(program_memory.dup, 0, input, output).run
      Integer(output.string)
    end
  end
end

