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
  length = 1
  
  while true
    length+=2
    x+=1
    
    # Calculte the right side of the square
    top = y + length - 2
    while y <= top
      updateSquare(data, x, y)
      return data[x][y] if data[x][y] > input
      y+=1
    end
    y-=1
    
    # Calculte the top of the square
    left = x - (length - 1)
    x-=1
    while x >= left
      updateSquare(data, x, y)
      return data[x][y] if data[x][y] > input
      x-=1
    end
    x+=1
    
    # Calculte the left side of the square
    bottom = y - (length - 1)
    y-=1
    while y >= bottom
      updateSquare(data, x, y)
      return data[x][y] if data[x][y] > input
      y-=1
    end
    y+=1
    
    # Calculte the bottom of the square
    right = x + (length - 1)
    x+=1
    while x <= right
      updateSquare(data, x, y)
      return data[x][y] if data[x][y] > input
      x+=1
    end
    x-=1
    #break if length == 5
  end
  
  return result
end

# Update the value of the square at position x,y
def updateSquare(data, x, y)
  data[x] = Hash.new if !data.has_key?(x)
      
  result =  fetchValue(data, x-1, y+1) + fetchValue(data, x, y+1) + fetchValue(data, x+1, y+1) +
            fetchValue(data, x-1, y)   +                            fetchValue(data, x+1, y)   +
            fetchValue(data, x-1, y-1) + fetchValue(data, x, y-1) + fetchValue(data, x+1, y-1)
  
  data[x][y] = result
end

# Return the value of the square at position x,y or return 0
def fetchValue(data, x, y)
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

puts "--- Part 1:"
puts "Result: #{part1(INPUT)}"

puts "--- Part 2:"
puts "Result: #{part2(INPUT)}"
