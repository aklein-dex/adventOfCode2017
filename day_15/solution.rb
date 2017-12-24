#!/usr/bin/env ruby

puts "--- Day 14: Disk Defragmentation ---"

# The input for this challenge
GEN_A = 277
GEN_B = 349

@FACT_A = 16807
@FACT_B = 48271

@MOD = 2147483647

def part2(a, b)

end

def part1(a, b)
  count = 0

  for i in 0..40000000
    a = a * FACT_A % MOD
    b = b * FACT_B % MOD
    count+= 1 if a.to_s(2).rjust(32,"0")[16..-1] == b.to_s(2).rjust(32,"0")[16..-1]
  end
  return count
end

puts "--- Part 1: #{part1(GEN_A, GEN_B)}"

