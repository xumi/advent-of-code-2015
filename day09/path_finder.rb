# This method is used to create an helper which allows us to check length both ways
# A -> B
# B -> A
def create_map(instructions)
  map = {}
  instructions.each do |instruction|
    road = parse_instruction(instruction)
    map[road[:a]] = {} unless map[road[:a]]
    map[road[:b]] = {} unless map[road[:b]]
    map[road[:a]][road[:b]] = road[:length]
    map[road[:b]][road[:a]] = road[:length]
  end
  map
end

def get_paths_length(paths, map)
  evaluated_paths = []
  # For all the paths
  paths.each do |path|
    length           = 0
    # We start nowhere
    current_position = nil
    # We loop through the path
    path.each do |destination|
      # We add the distance between the current position and the destination
      length += map[current_position][destination] if current_position
      # We move the to destination
      current_position = destination
    end
    # Let's save the path with its length, just in case we need it later...
    evaluated_paths << {path: path, length: length}
  end
  evaluated_paths
end

# Use the extract data from the input file
def parse_instruction(instruction)
  parts = instruction.match(/(\S+) to (\S+) = (\d+)/).to_a
  {
    a:      parts[1],     # Origin
    b:      parts[2],     # Destination
    length: parts[3].to_i # Distance
  }
end