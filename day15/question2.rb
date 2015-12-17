#!/usr/bin/ruby
#
# --- Day 15: Science for Hungry People ---
#
# --- Part Two ---
# 
# Your cookie recipe becomes wildly popular! Someone asks if you can make another recipe that has exactly 500 calories per cookie (so they can use it as a meal replacement). Keep the rest of your award-winning process the same (100 teaspoons, same ingredients, same scoring system).
# 
# For example, given the ingredients above, if you had instead selected 40 teaspoons of butterscotch and 60 teaspoons of cinnamon (which still adds to 100), the total calorie count would be 40*8 + 60*3 = 500. The total score would go down, though: only 57600000, the best you can do in such trying circumstances.
# 
# Given the ingredients in your kitchen and their properties, what is the total score of the highest-scoring cookie you can make with a calorie total of 500?
#

# Load the file containing our algorithm
require File.join File.dirname(__FILE__), 'searcher'

# Load our input from the input.txt file
input  = File.read('./input.txt')

# We define the calorie goal
amount_of_calories = 500

# Let's analyze!
answer = search(input, amount_of_calories)

# We display the result
puts answer