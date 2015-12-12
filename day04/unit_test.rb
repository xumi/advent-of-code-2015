#!/usr/bin/ruby

require 'test/unit'
extend Test::Unit::Assertions

# Load the first question
require File.join File.dirname(__FILE__), 'adventcoins'

# We only have example results for the first question (5 zeroes)
needle = '00000'

# The known answers
tests = {
  'abcdef'  => 609043,
  'pqrstuv' => 1048970
}

puts 'Start Unit Testing...'
tests.each do |key, value|
  assert_equal(value, search(key, needle))
end
puts 'Done.'