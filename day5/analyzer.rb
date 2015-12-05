#!/usr/bin/ruby

# No need for comments. You know why? Because Ruby is awesome.

def search(list)
  count = 0
  list.each_line do |string|
    count += 1 if is_a_nice_string?(string)
  end
  count
end

def is_a_nice_string?(s)
  has_enough_vowels?(s) and has_nice_twin?(s) and has_no_bad_couple?(s)
end

def has_enough_vowels?(string)
  vowels = 'aeiou' # Why no Y ? :'(
  count  = 0
  string.each_char do |letter|
    count += 1 if vowels.include?(letter)
  end
  count >= 3
end

def has_nice_twin?(string)
  string.each_char do |letter|
    return true if string.include?(letter*2)
  end
  false
end

def has_no_bad_couple?(string)
  bad_couples = ['ab','cd','pq','xy']
  bad_couples.each do |naughty_couple|
    return false if string.include?(naughty_couple)
  end
  true
end