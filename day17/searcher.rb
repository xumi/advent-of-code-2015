def search(input, target)
  # We get the list of container sizes
  container_sizes = parse_instructions(input)
  # We keep track of the amount of containers we use for each valid combination (question2)
  combinations_sizes = []
  # We keep track of all the valid combinations (match target)
  valid_combinations = []
  # We try combination of different sizes (1 container, 2 containers, 3, ...)
  (1..container_sizes.length).each do |combination_length|
    # We find all the possible combination of containers for this amount of containers
    container_sizes.combination(combination_length).each do |combination|
      # If the sum of all the size equals our target
      if combination.inject(:+) == target
        # We mark this combination as valid
        valid_combinations << combination
        # We save it's size
        combinations_sizes << combination.length
      end
    end
  end

  # This is the minimum amount of containers the elves can use to store [target] amount of eggnog
  minimum_amount_of_containers = combinations_sizes.min
  # We find how many combinations are possible with this amount of containers
  minimum_combinations_count = 0
  container_sizes.combination(minimum_amount_of_containers).each do |combination|
    minimum_combinations_count += 1 if combination.inject(:+) == target
  end
  # We return the solution (question1 and question2, together)
  {
    possible_combinations: valid_combinations.length,
    minimum_combinations: minimum_combinations_count
  }
end

def parse_instructions(input)
  # We collect each line and cast them as integer
  input.lines.map{|line| line.to_i }
end