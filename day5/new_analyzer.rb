#!/usr/bin/ruby

# This is the fancy new analyzer that Santa needs for the second question

def search(list)
  count = 0
  list.each_line do |string|
    count += 1 if is_a_nice_string?(string)
  end
  count
end

def is_a_nice_string?(s)
  has_twin_couples?(s) and has_threesome?(s)
end

def has_twin_couples?(string)
  previous_char     = nil
  string.each_char do |letter, index|
    if previous_char
      regexp = Regexp.new([previous_char,letter].join)
      return true if string.scan(regexp).length > 1
    end
    previous_char = letter
  end
  false
end

def has_threesome?(string) # whoops.
  string.each_char do |letter|
    regexp = Regexp.new([letter,'.',letter].join) # [letter][anything][letter]
    return true if regexp.match(string)
  end
  false
end