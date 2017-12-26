#!/usr/bin/env ruby

puts "--- Day 14: Disk Defragmentation ---"

# The input for this challenge
GEN_A = 277
GEN_B = 349

@FACT_A = 16807
@FACT_B = 48271

@MOD = 2147483647

def findNextNumber(nb, factor, multipleOf)
  loop do
    nb = nb * factor % @MOD
    break if nb % multipleOf == 0
  end
  return nb
end

# Use threads
def part2(a, b)
  count = 0
  
  for i in 0..5000000
    t1 = Thread.new{findNextNumber(a, @FACT_A, 4)}
    t2 = Thread.new{findNextNumber(b, @FACT_B, 8)}
    t1.join
    t2.join
    a = t1.value
    b = t2.value
    count+= 1 if a.to_s(2).rjust(32,"0")[16..-1] == b.to_s(2).rjust(32,"0")[16..-1]
  end
  return count
end

def part1(a, b)
  count = 0

  for i in 0..40000000
    a = a * @FACT_A % @MOD
    b = b * @FACT_B % @MOD
    count+= 1 if a.to_s(2).rjust(32,"0")[16..-1] == b.to_s(2).rjust(32,"0")[16..-1]
  end
  return count
end

if ARGV[0] == "2"
  puts "--- Part 2: (it will take some minutes to complete)..."
  puts "  Count: #{part2(GEN_A, GEN_B)}"
else
  puts "--- Part 1:  (it will take some minutes to complete)..."
  puts "  Count: #{part1(GEN_A, GEN_B)}"
end
