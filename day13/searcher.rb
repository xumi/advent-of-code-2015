#!/usr/bin/ruby

def search(input, add_myself=false)
	# We parse the instructions to have a more comprehensive set of rules
	rules 			 = parse_instructions(input.lines)
	# We get the list of people invited
  participants = rules.keys
  # The only thing to add for the second question
  participants << "Me" if add_myself
  # We calculate all the possible tables
  tables 			 = participants.permutation
  happiness_levels = []
  # For each possible arrangement we calculate the global happinness of it
  tables.each do |table|
  	happiness_levels << get_table_happinness(table, rules)
  end
  # We return the maximum level of happiness
  happiness_levels.max
end

def get_table_happinness(table, rules)
	# We initialize the count
	happiness = 0
	# We simulate a round table to simplify the search
	round_table = [table.last] + table + [table.first]
	# For each seat
	round_table.each_cons(3) do |on_the_left, person, on_the_right|
		# If this person has no preferences we just ignore
		next unless rules.has_key?(person)
		rule 				 = rules[person]
		# We add the happiness value for the person on the left
		happiness   += rule[on_the_left]  if rule.has_key?(on_the_left)
		# We add the happiness value for the person on the right
		happiness   += rule[on_the_right] if rule.has_key?(on_the_right)
	end
	# We return the total happiness of this table
	happiness
end

def parse_instructions(instructions)
	rules = {}
	# For each instruction
	instructions.each do |instruction|
		# We get a detailled version of this instruction
		rule = parse_instruction(instruction)
		# If we don't have rules for this person yet we initialize them
		rules[rule[:person]] ||= {} 
		# We save the charge for this neighbor
		rules[rule[:person]][rule[:neighbor]] = rule[:charge]
	end
	rules
end

def parse_instruction(instruction)
	# We split the string on each space
	parts    = instruction.split
	action	 = parts[2] 			# "gain" or "lose"
	charge 	 = parts[3].to_i	# the value
	# If this is a "lose" action then the charge should be negative
	charge  *= -1 if action == 'lose'
	# We return a detailled object with the data
	{
		person: 	parts.first,
		neighbor: parts.last.chomp('.'),
		charge:   charge
	}
end