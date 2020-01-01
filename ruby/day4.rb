$LOAD_PATH.unshift(File.expand_path("./lib/"))
require "password"

input = 382345..843167
passwords = input.select { |candidate| Password.valid?(candidate) }

puts "(part 1) Count: #{passwords.count}"
