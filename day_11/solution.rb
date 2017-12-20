#!/usr/bin/env ruby

puts "--- Day 11: Hex Ed ---"

# The input
path = File.open('input.txt', &:readline).chomp

x = 0
y = 0

furthest = 0

path.split(",").each do |step|
  if step == "n"
    y+=1
  elsif step == "ne"
    x+=1
    y+=1
  elsif step == "e"
    x+=1
  elsif step == "se"
    x+=1
    y+=-1
  elsif step == "s"
    y+=-1
  elsif step == "sw"
    x+=-1
    y+=-1
  elsif step == "w"
    x+=-1
  elsif step == "nw"
    x+=-1
    y+=1
  end
  
  if [x.abs, y.abs].max > furthest
    furthest = [x.abs, y.abs].max
  end
end

puts "Part 1: #{[x.abs, y.abs].max}"
puts "Part 1: #{furthest}"
