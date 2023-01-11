#!/usr/bin/crystal

# Turn the input text into a list of a list of integers
stuff = File.read("input.txt")
  .split('\n')[0..-2]
  .map(&.split("").map(&.to_i))

# checks left and right of the position in the list to determine
# whether the value at that position is greater than the other values
# in at least one of the directions
def viewable(list, pos)
  curr_val = list[pos]
  if (pos == 0) || (pos == list.size - 1)
    return true
  elsif list[0..pos-1].select{|s| s >= curr_val}.size == 0
    return true
  elsif list[pos+1..list.size].select{|s| s >= curr_val}.size == 0
    return true
  end

  return false
end

found = [] of Array(Bool)

# iterate through each row and calculate its viewability
(0..stuff.size-1).each do |x|
  current_found = [] of Bool
  (0..stuff.first.size-1).each do |y|
    current_found.push(false)
    if viewable(stuff[x], y)
      current_found[y] = true
    end
  end
  found.push(current_found)
end

# iterate through each column and calculate its viewability
# doesn't overwrite visibility if visible in another direction
(0..stuff.first.size-1).each do |y|
  current_found = [] of Bool
  (0..stuff.size-1).each do |x|
    if viewable(stuff.map(&.[y]), x) && !found[x][y]
      found[x][y] = true
    end
  end
end

# print the count of the number of true values
puts "part 1: #{found.sum(&.count{|s| s })}"

# checks in each direction how far until reaching a value greater than or equal to
# the positions value, multiplies the distances together for each direction
def viewScore(list_x, list_y, pos_x, pos_y)
  if (pos_x == 0) || (pos_y == 0) || (pos_x == list_x.size-1) || (pos_y == list_y.size-1)
    return 0
  end

  val = list_x[pos_x]
  score = 1

  run = 0
  (0..pos_x-1).reverse_each do |pos|
    run += 1
    break if list_x[pos] >= val
  end
  score *= run

  run = 0
  (pos_x+1..list_x.size-1).each do |pos|
    run += 1
    break if list_x[pos] >= val
  end
  score *= run

  run = 0
  (0..pos_y-1).reverse_each do |pos|
    run += 1
    break if list_y[pos] >= val
  end
  score *= run

  run = 0
  (pos_y+1..list_y.size-1).each do |pos|
    run += 1
    break if list_y[pos] >= val
  end
  score *= run

  return score
end

scores = [] of Array(Int32)

# calculate the view score for each position
(0..stuff.size-1).each do |x|
  scores.push([] of Int32)
  (0..stuff.first.size-1).each do |y|
    score = viewScore(stuff.map(&.[y]), stuff[x], x, y)
    scores[x].push(score)
  end
end

# print the maximum of the array of arrays
puts "part 2: #{(scores.map(&.max).max)}"
