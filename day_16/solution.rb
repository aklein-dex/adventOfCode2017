#!/usr/bin/env ruby

puts "--- Day 16: Permutation Promenade ---"

class Array
  def spin!(num)
    self.rotate!(-num)
  end

  def exchange!(i,j)
    self[i], self[j] = self[j], self[i]
    self
  end

  def partner!(a,b)
    i, j = self.find_index(a), self.find_index(b)
    self.exchange!(i,j)
  end
end

def danse(programs, moves)
  moves.each do |move|
    if move[0] == "s"
      rot = move[1..-1].to_i
      programs.spin!(rot)
    elsif move[0] == "x"
      args = move[1..-1].split("/")
      programs.exchange!(args[0].to_i, args[1].to_i)
    elsif move[0] == "p"
      programs.partner!(move[1],move[3])
    else
      p "Wrong move John Travolta!"
    end
  end
end

# My input for this challenge
moves = File.open('input.txt', &:readline).chomp.split(",")

# Part 1
programs = ("a".."p").to_a
danse(programs, moves)
puts "Part 1: #{programs.join}"

# Part 2
programs = ("a".."p").to_a
# we will check for cycles
states = Array.new

for i in 0..1000000000
  if states.include?(programs.join(""))
    puts "Part 2: #{states[1000000000 % i]}"
    break
  end
  
  states << programs.join("")
  danse(programs, moves)
end
