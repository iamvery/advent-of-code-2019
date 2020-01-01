class Password
  def self.valid?(value)
    digits = value.digits
    return false unless digits.count == 6
    return true
  end
end
