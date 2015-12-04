#!/usr/bin/ruby

# We need the digest library to have access to the MD5 hash method
require 'digest'

# Our search method expects 2 arguments:
# 	key: your input (or anything else)
# 	needle: the prefix you are looking for in the hash (00000 for instance)
def search(key, needle)
  # We starts at 0
  i = 0
  # We create our MD5 hasher
  hasher = Digest::MD5.new
  # We loop 
  while i+=1
  	# We concatenate the key and the current value in a single string
    message = [key,i].join
    # We hash it using MD5
    hash = hasher.hexdigest(message)
    # It the hash starts with the needle we return the solution
    return i if hash.to_s.start_with?(needle)
  end
end