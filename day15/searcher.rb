#!/usr/bin/ruby

def search(input)
  ingredients_data = parse_ingredients(input)
  ingredients   = ingredients_data.keys

  best_recipe = {score: 0, recipe: nil}

  get_different_dosages(ingredients).each do |recipe|
    properties_values = {}
    ingredients.each_with_index do |ingredient, index|
      ingredient_values = ingredients_data[ingredient]
      teaspoon_count = recipe[index]
      get_ingredient_values(ingredient_values, teaspoon_count).each do |property, sum|
        properties_values[property] ||= 0
        properties_values[property] += sum
      end
    end
    total = 1
    properties_values.values.each do |value|
      total = 0 and break if value < 0
      total *= value
    end
    if total > best_recipe[:score]
      best_recipe[:score]  = total
      best_recipe[:recipe] = recipe.map.with_index{|amount, i| [ingredients[i],amount]}
    end
  end

  # ------------------------------------------------------------
  # DEBUG
  puts '-'*30
  puts "The Recipe is:"
  puts best_recipe[:recipe].map{|r| r.join(' -> ')}
  puts "With a score of: #{best_recipe[:score]}"
  puts '-'*30
  # ------------------------------------------------------------

  best_recipe[:score]
end

def get_ingredient_values(ingredient, teaspoon_count)
  values = {}
  ingredient.each do |property, value|
    next if property == :calories
    values[property] = value * teaspoon_count
  end
  values
end

def get_different_dosages(ingredients)
  valid_permutations = []
  max_amount         = 100
  (0..max_amount).to_a.permutation(ingredients.length).each do |permutation|
    valid_permutations << permutation if permutation.inject(:+) == max_amount
  end
  valid_permutations
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