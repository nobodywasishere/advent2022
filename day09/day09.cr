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

def getNewPos(lead, follow)
  diff_x = (lead[:x] - follow[:x])
  diff_y = (lead[:y] - follow[:y])

  if diff_x.abs > 1 || diff_y.abs > 1
    if diff_x > 0
      follow[:x] += 1
    elsif diff_x < 0
      follow[:x] -= 1
    end
    if diff_y > 0
      follow[:y] += 1
    elsif diff_y < 0
      follow[:y] -= 1
    end
  end
end

def printMap(knots, width, hight)
  (0..hight).reverse_each do |h|
    line = [] of String
    (0..width).each do |w|
      if knots.first == {:x => w, :y => h}
        line.push("H")
      elsif knots.any?{|k| k == {:x => w, :y => h}}
        line.push("T")
      else
        line.push(".")
      end
    end
    puts line.join("")
  end
end

knot_pos = [] of Hash(Symbol, Int32)
knot_cnt = 10
knot_visits = [] of Hash(Symbol, Int32)

(0..knot_cnt-1).each do |knot|
  knot_pos.push({:x => 0, :y => 0})
end

# printMap(knot_pos, width, hight)

stuff.each do |step|
  # puts "step: #{step}"
  dir = step[0]
  cnt = step[1].to_i

  # puts step

  (0..cnt-1).each do
    if dir == "L"
      knot_pos.first[:x] -= 1
    elsif dir == "R"
      knot_pos.first[:x] += 1
    elsif dir == "U"
      knot_pos.first[:y] += 1
    elsif dir == "D"
      knot_pos.first[:y] -= 1
    else
      puts "Not a dir: #{dir}"
    end

    (1..knot_cnt-1).each do |knot|
      getNewPos(knot_pos[knot-1], knot_pos[knot])
    end

    # printMap(knot_pos, width, hight)
    # puts ""

    knot_visits.push(knot_pos.last.dup) if !knot_visits.includes? knot_pos.last
  end

end

# printMap(knot_pos, width, hight)

puts "part 2: #{knot_visits.size}"
