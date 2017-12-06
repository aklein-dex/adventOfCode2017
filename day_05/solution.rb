#!/usr/bin/env ruby

puts "--- Day 5: A Maze of Twisty Trampolines, All Alike ---"

if ARGV[0] == "2"
    puts "--- Part 2:"
    part = 'part2'
else
    puts "--- Part 1:"
    part = 'part1'
end

# Just increment by one
def part1(instructions, previous)
  instructions[previous]+=1
end

# Increment by 1 if the value is less than 3
def part2(instructions, previous)
  if instructions[previous] >= 3
    instructions[previous]-=1
  else
    instructions[previous]+=1
  end
end

instructions = Array.new
input = File.open('input.txt', 'r')
input.each_line do |line|
    instructions << line.to_i
end
input.close

# the current index
i = 0

# the value of the previous index

previous = 0
steps = 0

# Run the instructions
while i < instructions.size
  previous = i
  i = i + instructions[i]
  send(part, instructions, previous)
  steps+=1
end

puts "Steps: #{steps}"

