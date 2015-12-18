# Load the file containing our model
require File.join File.dirname(__FILE__), 'grid'

def search(input, with_corners=false)
  # We get a two dimensional array of 0 and 1 instead of . and #  
  instructions = parse_instructions(input.lines)
  # We create our grid object based on the two dimensional array
  grid   = Grid.new(instructions, with_corners)
  # We need to do [amount] iterations
  amount = 100
  # We ask the grid to iterate [amount] times
  (1..amount).each{ grid.next! }
  # We return the global grid power
  grid.power
end

def parse_instructions(instructions)
  # For each line
  instructions.map do |line|
    # We return and array
    line.chomp.chars.map do |char|
      # of 1 or 0
      char == '#' ? 1 : 0
    end
  end
end