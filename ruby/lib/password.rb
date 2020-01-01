class Password
  def self.valid?(value)
    return false unless value.digits.count == 6
    return true
  end
end
