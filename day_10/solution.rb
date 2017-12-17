#!/usr/bin/env ruby

puts "--- Day 10: Knot Hash ---"

# The input for this challenge
lengths = [ 165,1,255,31,87,52,24,113,0,91,148,254,158,2,73,153 ]

# Initial list of numbers
numbers = Array(0..255)

skip = 0

position = 0

lengths.each do |length|
  moved = 0
  start = position
  fin = (position + length-1) % 256
  
  while moved <= length/2
    #puts "[#{start}]:#{numbers[start]} <--> [#{fin}]:#{numbers[fin]}"
    tmp = numbers[start]
    numbers[start] = numbers[fin]
    numbers[fin] = tmp
    
    start = (start + 1) % 256
    fin   = (fin   - 1) % 256
    moved+=1
  end
  
  position = (position + length+ skip) % 256 
  skip+=1
end


result = numbers[0] * numbers[1]
puts "Part 1: #{result}"
