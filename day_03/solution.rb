#!/usr/bin/env ruby

puts "--- Day 3: Spiral Memory ---"

if ARGV[0] == "2"
    puts "--- Part 2:"
    
else
    puts "--- Part 1:"
    
end

# My input for this challenge
INPUT = 312051

# Formula to find the bottom right corner of a layer: (2n + 1)^2
layer = 1
#bottom right corner
corner = 9
while corner < INPUT
  corner = (2 * layer + 1) ** 2
  layer = layer + 1
end

puts "  Layer: #{layer}"
puts "  Corner: #{corner}"

# This is the length of the square's side
side_length =  Math.sqrt(corner)
puts "  Square's side: #{side_length}"

# Have to find how far away from a corner the INPUT is located
distance = INPUT % side_length
puts "  Distance: #{distance}"

# Number of steps: half of the side length vertically + half of the side length horizontally - distance
# which is: (side_length/2) + (side_length/2) - distance
result = side_length - distance

puts result

