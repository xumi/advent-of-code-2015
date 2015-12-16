#!/usr/bin/ruby

def search(input, calories_count=nil)
  # We get the list of ingredients and their properties from the source
  ingredients_data  = parse_ingredients(input)
  # The ingredients list (names)
  ingredients       = ingredients_data.keys

  # The variable saving the best recipe yet
  best_recipe = {score: 0, recipe: nil}

  # We find all the different dosages possible
  get_different_dosages(ingredients).each do |recipe|
    properties_values = {}

    ingredients.each_with_index do |ingredient, index|
      # We get the nutritional values of this ingredient
      ingredient_values = ingredients_data[ingredient]
      # We get how many teaspoons we need for this recipe
      teaspoon_count    = recipe[index]
      # We get the nutritional value for each ingredient for each amount of teaspoons
      get_ingredient_values(ingredient_values, teaspoon_count).each do |property, sum|
        # We initialize the value if needed
        properties_values[property] ||= 0
        # We add the value to the count
        properties_values[property] += sum
      end
    end
    # We calculate the score of this recipe
    total = 1
    properties_values.each do |property, value|
      # We ignore calories for the score
      next if property == :calories
      # If we have a negative total then the whole score is 0
      total = 0 and break if value < 0
      # We multiply all the values
      total *= value
    end
    # We are picky about calories count (question 2) we check for that here
    next if !calories_count.nil? && properties_values[:calories] != calories_count
    # If this is the best recipe yet we save it
    if total > best_recipe[:score]
      best_recipe[:score]  = total
      # Just for fun we want to save the recipe
      best_recipe[:recipe] = recipe.map.with_index{|amount, i| [ingredients[i],amount]}
    end
  end
  # Let's display the recipe
  puts best_recipe
  # We return the best recipe score
  best_recipe[:score]
end

def get_ingredient_values(ingredient, teaspoon_count)
  values = {}
  # For each ingredient we get the value for that amount of teaspoons
  ingredient.each do |property, value|
    values[property] = value * teaspoon_count
  end
  values
end

def get_different_dosages(ingredients)
  # The exact amount of teaspoons we have to use for all recipes
  max_amount = 100
  # All the possible dosages that use exactly max_amount teaspoons
  dosages = []
  # We find the combinations
  (0..max_amount).each do |i|
    l = max_amount - i
    next if l < 0
    (0..max_amount).each do |j|
      l = max_amount - i - j
      next if l < 0
      (0..max_amount).each do |k|
        l = max_amount - i - j - k
        next if l < 0
        dosages << [i,j,k,l]
      end
    end
  end
  dosages
end

def parse_ingredients(list)
  ingredients = {}
  list.lines.each do |line|
    parts = line.split
    ingredient = parts.first.chomp(':')
    ingredients[ingredient] = {
      capacity:   parts[2].to_i,
      durability: parts[4].to_i,
      flavor:     parts[6].to_i,
      texture:    parts[8].to_i,
      calories:   parts[10].to_i
    }
  end
  ingredients
end