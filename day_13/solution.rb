#!/usr/bin/env ruby

puts "--- Day 13: Packet Scanners ---"

# Note: I could have simplify this, because the only important thing is
#       if the position is at 0 or not (it doesn't matter if the position is 3 or 4 or etc.).
def getScannerPosition(depth, pico)
  # Length of a cycle before the scanner comes back to position 0
  cycle = (2*depth) - 2
  
  # Position of the scanner
  position = pico % cycle
  
  # If true, then the scanner is on his way back to position 0
  if position >= depth
    position = (depth-1) - (position - (depth-1))
  end
  
  return position
end

# Firewall rules
firewall = Array.new

# Parse the file
input = File.open('input.txt', 'r')
input.each_line do |line|
  layer = line.chomp.split(": ")
  firewall[layer[0].to_i] = layer[1].to_i
end
input.close

# Send the packet after a delay of "pico" picoseconds.
# If strict is true then it will return -1 if get caught.
# If strict is false, then it will continue to run and return the severity.
def sendPacket(firewall, pico, strict)
  result = 0
  
  firewall.each_with_index do |depth, layer|
    if depth == nil
      pico+=1
      next
    end
    
    position = getScannerPosition(depth, pico)
    
    if position == 0
      return -1 if strict
      result+=depth*layer 
    end

    pico+=1
  end
  
  return result
end

# Find the number of picoseconds to delay
def part2(firewall)
  delay = 10
  
  while delay < 5000000
    result = sendPacket(firewall, delay, true)
    return delay if result == 0
    delay+=1
  end
  
  puts "reach max delay #{delay}"
  return -1
end

# Find the severity when being caught
def part1(firewall)
  return sendPacket(firewall, 0, false)
end

puts "Part 1: #{part1(firewall)}"
puts "Part 2: #{part2(firewall)}"
