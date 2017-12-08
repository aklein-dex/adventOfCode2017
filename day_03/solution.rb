#!/usr/bin/env ruby

puts "--- Day 3: Spiral Memory ---"

# My input for this challenge
INPUT = 312051

def part2(input)
  data = Hash.new
  data[0] = Hash.new
  data[0][0] = 1
  result = 1
  
  x = 0
  y = 0
  layer = 0
  
  while result < input
    
    data[x] = Hash.new if !data.has_key?(x)
    
    result =  dataValue(data, x-1, y+1) + dataValue(data, x, y+1) + dataValue(data, x+1, y+1) +
              dataValue(data, x-1, y)   +                           dataValue(data, x+1, y)   +
              dataValue(data, x-1, y-1) + dataValue(data, x, y-1) + dataValue(data, x+1, y-1)
    
    data[x][y] = result
  end
  
  return result
end

def dataValue(data, x, y)
  if data.has_key?(x) and data[x].has_key?(y)
    return data[x][y]
  else
    return 0
  end
end

def part1(input)
  # Formula to find the bottom right corner of a layer: (2n + 1)^2
  layer = 1
  #bottom right corner
  corner = 9
  while corner < input
    corner = (2 * layer + 1) ** 2
    layer = layer + 1
  end

  puts "  Layer: #{layer}"
  puts "  Corner: #{corner}"

  # This is the length of the square's side
  side_length =  Math.sqrt(corner)
  puts "  Square's side: #{side_length}"

  # Have to find how far away from a corner the input is located
  distance = input % side_length
  puts "  Distance: #{distance}"

  # Number of steps: half of the side length vertically + half of the side length horizontally - distance
  # which is: (side_length/2) + (side_length/2) - distance
  return side_length - distance
end

if ARGV[0] == "2"
    puts "--- Part 2:"
    result = part2(INPUT)
else
    puts "--- Part 1:"
    result = part1(INPUT)
end


puts "Result: #{result}"
