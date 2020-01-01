class Password
  def self.valid?(value)
    digits = value.digits
    pairs = digits.each_cons(2)
    return false unless digits.count == 6
    return false unless pairs.any? { |(a,b)| a == b }
    return false unless pairs.all? { |(a,b)| a >= b }
    return true
  end
end
