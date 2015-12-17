#!/usr/bin/ruby
#
# --- Day 17: No Such Thing as Too Much ---
#
# --- Part Two ---
# 
# While playing with all the containers in the kitchen, another load of eggnog arrives! The shipping and receiving department is requesting as many containers as you can spare.
# 
# Find the minimum number of containers that can exactly fit all 150 liters of eggnog. How many different ways can you fill that number of containers and still hold exactly 150 litres?
# 
# In the example above, the minimum number of containers was two. There were three ways to use that many containers, and so the answer there would be 3.
#

# Load the file containing our algorithm
require File.join File.dirname(__FILE__), 'searcher'

# Load our input from the input.txt file
input  = File.read('./input.txt')

# How many litter of eggnog we have to store
total = 150

# Let's analyze!
answer = search(input, total)

# We display the result
puts answer[:minimum_combinations]