#!/usr/bin/env ruby
require 'set'
puts "--- Day 4: High-Entropy Passphrases ---"

# a passphrase is invalid if any word's letters can be rearranged to form any other word in the passphrase.
def part2_is_valid(line)
  words = line.split(" ")
  set = Set.new
  
  words.each do |word|
    # create all the permutations
    word_permutations = word.chars.to_a.permutation.map &:join
    
    # here we can remove duplicate. For example if the word is "aba" -> aba, aab, baa, aba, aab
    # We don't need the last 2.
    word_permutations = word_permutations.uniq
    
    word_permutations.each do |perm|
      return false if set.add?(perm) == nil
    end
  end
  
  return true
end

# a valid passphrase must contain no duplicate words
def part1_is_valid(line)
  words = line.split(" ")
  return words.uniq.length == words.length
end

result_part1 = 0
result_part2 = 0

input = File.open('input.txt', 'r')
input.each_line do |line|
    result_part1 += 1 if part1_is_valid(line)
    result_part2 += 1 if part2_is_valid(line)
end
input.close

puts "--- Part 1: #{result_part1}"
puts "--- Part 2: #{result_part2}"

