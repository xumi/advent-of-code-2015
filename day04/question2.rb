#!/usr/bin/ruby
#
# http:#adventofcode.com/day/4
#
# --- Day 4: The Ideal Stocking Stuffer ---
#
# --- Part Two ---
# 
# Now find one that starts with six zeroes.

# Load the file containing our mining method
require File.join File.dirname(__FILE__), 'adventcoins'

# Load our input from the input.txt file
input  = File.new('./input.txt', 'r').gets
# The prefix we are looking for
needle = '000000'
# Let's mine!
asnwer = search(input, needle)

# We display the result
puts [asnwer, 'is a valid gift!'].join(' ')