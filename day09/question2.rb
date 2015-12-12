#!/usr/bin/ruby
# 
# --- Day 9: All in a Single Night ---
# 
# --- Part Two ---
# 
# The next year, just to show off, Santa decides to take the route with the longest distance instead.
# 
# He can still start and end at any two (different) locations he wants, and he still must visit each location exactly once.
# 
# For example, given the distances above, the longest route would be 982 via (for example) Dublin -> London -> Belfast.
# 
# What is the distance of the longest route?
# 

# Load our input from the input.txt file
input = File.read('./input.txt')

# Load the file containing our path finding method
require File.join File.dirname(__FILE__), 'path_finder'

def search(input)
  # We create a map to help us deal with the direction in both ways 
  map             = create_map(input.lines)
  # We collect all the differents destinations
  destinations    = map.keys
  # We find all the different paths possible 
  paths           = destinations.permutation
  # Using the map above we find the length of each possible path
  evaluated_paths = get_paths_length(paths, map)
  # We get all the different lengths
  lengths = evaluated_paths.map{|path| path[:length]}
  # We return the maximum
  lengths.max
end

puts "The longest distance is #{search(input)}"