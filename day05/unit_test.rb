#!/usr/bin/ruby

require 'test/unit'
extend Test::Unit::Assertions

if ARGV.first == 'new'
	puts 'USE THE NEW ANALYZER:'
	# Load the analyzer for the second question
	require File.join File.dirname(__FILE__), 'new_analyzer'
	# The known answers
	tests = {
	  'qjhvhtzxzqqjkmpb'  => 1, # nice
	  'xxyxx'             => 1, # nice
	  'uurcxstgmygtbstg'  => 0, # naughty
	  'ieodomkazucvgmuy'  => 0  # naughty
	}
else
	puts 'USE THE OLD ANALYZER:'
	# Load the analyzer for the first question
	require File.join File.dirname(__FILE__), 'analyzer'
	# The known answers
	tests = {
	  'ugknbfddgicrmopn'  => 1, # nice
	  'aaaa'              => 1, # nice
	  'jchzalrnumimnmhp'  => 0, # naughty
	  'haegwjzuvuyypxyu'  => 0, # naughty
	  'dvszwmarrgswjxmb'  => 0  # naughty
	}
end

puts 'Start Unit Testing...'
tests.each do |key, value|
  assert_equal(value, search(key), key)
end
puts 'Done.'