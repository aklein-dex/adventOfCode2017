#!/usr/bin/env ruby

puts "--- Day 10: Knot Hash ---"

# The input for this challenge
lengths = [ 165,1,255,31,87,52,24,113,0,91,148,254,158,2,73,153 ]

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

def part2(lengths)
  result = 0
  
  # Add elements as specified in the description
  ascii = lengths.join(",").bytes + [17, 31, 73, 47, 23]
  
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

def part1(lengths)
  numbers = twist(lengths, 1)
  return numbers.take(2).reduce(:*)
end

puts "--- Part 1: #{part1(lengths)}"
puts "--- Part 2: #{part2(lengths)}"
