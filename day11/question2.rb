#!/usr/bin/ruby
#
# --- Day 11: Corporate Policy ---
#
# --- Part Two ---
# 
# Santa's password expired again. What's the next one?
#

# Load the file containing our algorithm
require File.join File.dirname(__FILE__), 'searcher'

# Load our input from the input.txt file
input  = File.read('./input.txt')

# Let's analyze!
first_password = search(input)
# One more time...
answer = search(first_password)

# We display the result
puts "Santa's new password is #{answer}"