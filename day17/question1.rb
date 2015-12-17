#!/usr/bin/ruby
#
# --- Day 17: No Such Thing as Too Much ---
# 
# The elves bought too much eggnog again - 150 liters this time. To fit it all into your refrigerator, you'll need to move it into smaller containers. You take an inventory of the capacities of the available containers.
# 
# For example, suppose you have containers of size 20, 15, 10, 5, and 5 liters. If you need to store 25 liters, there are four ways to do it:
# 
# 15 and 10
# 20 and 5 (the first 5)
# 20 and 5 (the second 5)
# 15, 5, and 5
# Filling all containers entirely, how many different combinations of containers can exactly fit all 150 liters of eggnog?
#
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
puts answer[:possible_combinations]