#!/usr/bin/ruby
#
# --- Day 13: Knights of the Dinner Table ---
#
# --- Part Two ---
# 
# In all the commotion, you realize that you forgot to seat yourself. At this point, you're pretty apathetic toward the whole thing, and your happiness wouldn't really go up or down regardless of who you sit next to. You assume everyone else would be just as ambivalent about sitting next to you, too.
# 
# So, add yourself to the list, and give all happiness relationships that involve you a score of 0.
# 
# What is the total change in happiness for the optimal seating arrangement that actually includes yourself?
#

# Load the file containing our algorithm
require File.join File.dirname(__FILE__), 'searcher'

# Load our input from the input.txt file
input  = File.read('./input.txt')

# This flag tells to search method to include myself
include_myself = true

# We search the answer
answer = search(input, include_myself)

# We display the result
puts answer