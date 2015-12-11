#!/usr/bin/ruby

require 'test/unit'
extend Test::Unit::Assertions

# Load the analyzer for the first question
require File.join File.dirname(__FILE__), 'searcher'
# The known answers
tests = {
  'abcdefgh'  => 'abcdffaa',
  'ghijklmn'  => 'ghjaabcc',
}

puts 'Start Unit Testing...'
tests.each do |key, value|
  assert_equal(value, search(key), key)
end
puts 'Done.'