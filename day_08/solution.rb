#!/usr/bin/env ruby

puts "--- Day 8: I Heard You Like Registers ---"

# Apply the operation
def applyOperation(op, val_reg, val)
  if op == "inc"
    return val_reg + val
  elsif op == "dec"
    return val_reg - val
  else
    puts "Unkown operation: #{op}"
  end
end

instructions = Hash.new
max = -999

input = File.open('input.txt', 'r')
input.each_line do |line|
    elements = line.split(" ")
    reg      = elements[0]
    op       = elements[1]
    val      = elements[2].to_i
    reg_cond = elements[4]
    cond     = elements[5]
    condr    = elements[6].to_i
    
    instructions[reg]      = 0 if !instructions.has_key?(reg)
    instructions[reg_cond] = 0 if !instructions.has_key?(reg_cond)
    
    if eval "#{instructions[reg_cond]} #{cond} #{condr}"
      instructions[reg] = applyOperation(op, instructions[reg], val)
      max = [instructions[reg], max].max 
    end
end
input.close

puts "--- Part 1: max value at the end of the process: #{instructions.values.max}"
puts "--- Part 2: max value during process: #{max}"
