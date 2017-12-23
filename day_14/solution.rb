#!/usr/bin/env ruby

puts "--- Day 14: Disk Defragmentation ---"

# The input for this challenge
input = "stpzcrnm"

# Same as in day 10
def twist(lengths, rounds)
  # Initial list of numbers
  numbers = Array(0..255)

  skip = 0

  position = 0
  
  while rounds > 0
    lengths.each do |length|
      
      moved = 0
      start = position
      fin   = (position + length-1) % 256
      
      while moved < length/2
        tmp = numbers[start]
        numbers[start] = numbers[fin]
        numbers[fin] = tmp
        
        start = (start + 1) % 256
        fin   = (fin   - 1) % 256
        moved+=1
      end
      
      position = (position + length + skip) % 256 
      skip+=1
    end
    rounds-=1
  end

  return numbers
end

# Same as in day 10 except param is a string
def knot_hash(input)
  result = 0
  
  # Add elements as specified in the description
  ascii = input.bytes + [17, 31, 73, 47, 23]
  
  # Twist it 64 times
  numbers = twist(ascii, 64)
  
  # Xor groups of 16 elements
  dense_hash = Array.new
  numbers.each_slice(16) do |slice|
    dense_hash << slice.reduce(&:^)
  end
  
  # Convert to hexadecimal
  hexa = Array.new
  dense_hash.each do |d|
    hexa << d.to_s(16).rjust(2, '0')
  end
  
  return hexa.join("")
end

# Set to 0 all the next blocks
def remove(disk, y,x)
  return if y < 0 or x < 0 or x > 127 or y > 127
  
  if disk[y][x] == "1"
    disk[y][x] = 0
    remove(disk, y-1, x)
    remove(disk, y+1, x)
    remove(disk, y, x+1)
    remove(disk, y, x-1)
  end

end

used_square = 0
disk = Array.new

for i in 0..127
  row = knot_hash("#{input}-#{i}")
  row_bin = row.hex.to_s(2).rjust(row.size*4, '0')
  used_square+=row_bin.count("1")
  disk << row_bin.split("")
end

regions = 0

for y in 0..127
  for x in 0..127
    if disk[y][x] == "1"
      regions+=1
      remove(disk, y, x)
    end
  end
end

puts "--- Part 1: #{used_square}"
puts "--- Part 2: #{regions}"
