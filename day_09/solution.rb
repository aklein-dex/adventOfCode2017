#!/usr/bin/env ruby

puts "--- Day 9: Stream Processing ---"

stream = File.open('input.txt', &:readline).chomp

ignore = false
garbage = false
result = 0
stack = Array.new
part2 = 0

stream.chars.each do |c|
  if ignore
    ignore = false
    next
  end
  
  if c == '!'
      ignore = true
  elsif c == '{' and !garbage
    stack.push c
  elsif c == '}' and !garbage
    result+=1*stack.size
    stack.pop
  elsif c == '<' and !garbage
    garbage = true
  elsif c == '>'
    garbage = false
  else
    part2+=1 if garbage
  end

end

puts "--- Part 1: #{result}"
puts "--- Part 2: #{part2}"

