#!/usr/bin/ruby

def search(input)

  new_password = input
  # The password should always have 8 characters
  length_limit = new_password.length

  # We stop the search if we hit the case where we tried all the possible iteration of 8 characters
  while new_password.length == length_limit
    # We increase the password (a => b, zz => aaa)
    new_password = new_password.next
    # We test if this is valid password. If so we return it as the solution
    return new_password if is_valid_password?(new_password)
  end
  '[NO SOLUTION]'
end

def is_valid_password?(string)
  as_no_look_alike_char?(string) and has_two_couples_char?(string) and has_increasing_strengh_chars?(string)
end

def has_increasing_strengh_chars?(string)
  # We save the letters we tested
  done = {}
  # For each character of string
  string.each_char do |letter|
    # no need to test the same letter twice
    next if done[letter]
    # create the suite (a => abc, b => bcd, ... )
    needle = [letter, letter.next, letter.next.next].join('')
    # If we hit the case where we deal with y => yzaa or z => zaaab
    next if needle.length>3 
    # We flag the letter to avoid testing it again
    done[letter] = true
    # We create a regexp to match the needle
    regexp = Regexp.new(needle)
    # We the string matches the regexp then we have a increasing strengh
    return true if string.match(regexp)
  end
  # There is no increased strength in this string
  false
end

def has_two_couples_char?(string)
  # We try to find one couple of char
  first_couple_letter  = find_couple_char(string)
  # If we find one
  if first_couple_letter
    # We try for another one
    return true if find_couple_char(string, first_couple_letter)
  end
  # We were unable to find two couples
  false
end

def find_couple_char(string, which_is_not=nil)
  # We save the letters we tested
  done = {}
  # For each character of string
  string.each_char do |letter|
    # We we provided a letter that we should ignore
    next if letter == which_is_not
    # If we already tested this letter
    next if done[letter]
    # We create the regexp containing the couple
    regexp = Regexp.new([letter,letter].join)
    # We test the existence of the couple
    return letter if string.scan(regexp).length > 0
    # We flag the letter to avoid testing it again
    done[letter] = true
  end
  nil
end

def as_no_look_alike_char?(string)
  # We try to find forbidden letters in string.
  string.match(/[iol]/).nil?
end

