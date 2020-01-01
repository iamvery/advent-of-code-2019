class Password
  def self.valid?(value)
    digits = value.digits
    pairs = digits.each_cons(2)
    return false unless digits.count == 6
    return false unless pairs.all? { |(a,b)| a >= b }
    return false unless digits.chunk_while { |a,b| a == b }.map(&:count).any? { |c| c == 2 }
    return true
  end
end
