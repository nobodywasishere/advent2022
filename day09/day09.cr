#!/usr/bin/crystal

# Turn the input text into a list of a list of integers
stuff = File.read("input.txt")
  .split('\n')[0..-2]
  .map(&.split(' '))

h_pos_x = 0
h_pos_y = 0

t_pos_x = 0
t_pos_y = 0

t_visits = [] of Array(Int32)
t_visits.push([0,0])

width = 6
hight = 5

# (0..hight).reverse_each do |h|
#   line = [] of String
#   (0..width).each do |w|
#     if w == h_pos_x && h == h_pos_y
#       line.push("H")
#     else
#       line.push(".")
#     end
#   end
#   puts line.join("")
# end
# puts ""

stuff.each do |step|
  # puts "step: #{step}"
  dir = step[0]
  cnt = step[1].to_i

  (0..cnt-1).each do
    if dir == "L"
      h_pos_x -= 1
    elsif dir == "R"
      h_pos_x += 1
    elsif dir == "U"
      h_pos_y += 1
    elsif dir == "D"
      h_pos_y -= 1
    else
      puts "Not a dir: #{dir}"
    end

    diff_x = (h_pos_x - t_pos_x)
    diff_y = (h_pos_y - t_pos_y)

    if diff_x.abs > 1 || diff_y.abs > 1
      if diff_x > 0
        t_pos_x += 1
      elsif diff_x < 0
        t_pos_x -= 1
      end
      if diff_y > 0
        t_pos_y += 1
      elsif diff_y < 0
        t_pos_y -= 1
      end
    end

    t_visits.push([t_pos_x,t_pos_y]) if !t_visits.includes? [t_pos_x,t_pos_y]

    # puts "#{h_pos_x}, #{h_pos_y}"
    # puts "#{t_pos_x}, #{t_pos_y}"

    # (0..hight).reverse_each do |h|
    #   line = [] of String
    #   (0..width).each do |w|
    #     if w == h_pos_x && h == h_pos_y
    #       line.push("H")
    #     elsif w == t_pos_x && h == t_pos_y
    #       line.push("T")
    #     else
    #       line.push(".")
    #     end
    #   end
    #   puts line.join("")
    # end
    # puts ""

    # gets
  end
end

puts "part 1: #{t_visits.size}"
