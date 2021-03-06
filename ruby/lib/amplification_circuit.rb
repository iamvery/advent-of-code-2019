require "stringio"
require "computer"

module AmplificationCircuit
  def self.max(program, phase_setting_range: 0..4)
    phase_setting_range.to_a
      .permutation(5)
      .map { |sequence| [sequence, call(program, sequence)] }
      .max { |(_,a),(_,b)| a <=> b }
  end

  def self.call(program, phase_setting_sequence)
    first_read, first_write = IO.pipe
    first_write.puts phase_setting_sequence[0]
    second_read, second_write = IO.pipe
    second_write.puts phase_setting_sequence[1]
    third_read, third_write = IO.pipe
    third_write.puts phase_setting_sequence[2]
    fourth_read, fourth_write = IO.pipe
    fourth_write.puts phase_setting_sequence[3]
    fifth_read, fifth_write = IO.pipe
    fifth_write.puts phase_setting_sequence[4]

    first_write.puts 0
    Thread.new { Computer.call(program.dup, first_read, second_write) }
    Thread.new { Computer.call(program.dup, second_read, third_write) }
    Thread.new { Computer.call(program.dup, third_read, fourth_write) }
    Thread.new { Computer.call(program.dup, fourth_read, fifth_write) }
    Thread.new { Computer.call(program.dup, fifth_read, first_write) }.join

    Integer(first_read.gets)
  end
end

