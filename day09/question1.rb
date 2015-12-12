#!/usr/bin/ruby
# 
# --- Day 9: All in a Single Night ---
# 
# Every year, Santa manages to deliver all of his presents in a single night.
# 
# This year, however, he has some new locations to visit; his elves have provided him the distances between every pair of locations. He can start and end at any two (different) locations he wants, but he must visit each location exactly once. What is the shortest distance he can travel to achieve this?
# 
# For example, given the following distances:
# 
# London to Dublin = 464
# London to Belfast = 518
# Dublin to Belfast = 141
# The possible routes are therefore:
# 
# Dublin -> London -> Belfast = 982
# London -> Dublin -> Belfast = 605
# London -> Belfast -> Dublin = 659
# Dublin -> Belfast -> London = 659
# Belfast -> Dublin -> London = 605
# Belfast -> London -> Dublin = 982
# The shortest of these is London -> Dublin -> Belfast = 605, and so the answer is 605 in this example.
# 
# What is the distance of the shortest route?
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
  # We return the minimum
  lengths.min
end

puts "The shortest distance is #{search(input)}"