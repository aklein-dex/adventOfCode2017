#!/usr/bin/env ruby
require 'set'

puts "--- Day 6: Memory Reallocation ---"

# Puzzle input
memory = [ 14, 0, 15, 12, 11, 11, 3, 5, 1, 6, 8, 4, 9, 1, 8, 4 ]

# Redistribution cycles
steps = 0

# The key is the elements of the memory joined by ";". 
# The value is at which step it was proceed.
cycle = Hash.new

joined = memory.join(";")

start = 0

loop do
  cycle[joined] = steps
  
  max = memory.max
  # if 2 elements have the same value, we take the one at the lowest index
  for i in 0..memory.size
    if memory[i] == max
      start = i + 1
      memory[i] = 0
      break
    end
  end
  
  # redistribute blocks
  for i in 0..max-1
    memory[(start+i)%memory.size]+=1
  end
  
  steps+=1
  joined = memory.join(";")
  
  break if cycle.has_key?(joined)
end

cycles = steps - cycle[joined]

puts "Part 1: #{steps}"
puts "Part 2: #{cycles}"

