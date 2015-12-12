#!/usr/bin/ruby
# 
# --- Day 8: Matchsticks ---
# 
# --- Part Two ---
# 
# Now, let's go the other way. In addition to finding the number of characters of code, you should now encode each code representation as a new string and find the number of characters of the new encoded representation, including the surrounding double quotes.
# 
# For example:
# 
# "" encodes to "\"\"", an increase from 2 characters to 6.
# "abc" encodes to "\"abc\"", an increase from 5 characters to 9.
# "aaa\"aaa" encodes to "\"aaa\\\"aaa\"", an increase from 10 characters to 16.
# "\x27" encodes to "\"\\x27\"", an increase from 6 characters to 11.
# Your task is to find the total number of characters to represent the newly encoded strings minus the number of characters of code in each original string literal. For example, for the strings above, the total encoded length (6 + 9 + 16 + 11 = 42) minus the characters in the original code representation (23, just like in the first part of this puzzle) is 42 - 23 = 19.
# 

# Load our input from the input.txt file
input  = File.read('./input.txt')

# The encoding method
def encode_line(line)
	# Target the chararacters we need to encode
	catch_regex = /["\\]/
	# And replace them with their encoded version
	replacement = {
		'\\' => '\\\\',
		'"' => '\\"'
	}
	# Execute the replace in one shot
	line = line.gsub(catch_regex, replacement)
	# Finally add double quotes around the string
	'"'+line+'"'
end

literal_count = 0
encoded_count = 0

input.each_line do |line|
	# We return the line break \n
	clean_line = line.chomp
	# We get the length the given string
	literal_count += clean_line.length
	# We get the length of the encoded string
	encoded_count += encode_line(clean_line).length
end

puts "Answer: #{encoded_count - literal_count}"