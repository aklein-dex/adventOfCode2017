#!/usr/bin/env ruby

puts "--- Day 12: Digital Plumber ---"

class Program
  attr_accessor :id, :connections
  
  def initialize(id)
    @id = id
    @connections = Array.new
  end
  
  def connectTo(prog)
    @connections << prog
  end
end

# Could have create a function but wanted to extend Hash class for fun
class Hash
  def add?(key)
    if self.has_key?(key)
      return self[key]
    else
      prog = Program.new(key)
      self[key] = prog
      return prog
    end
  end
end

# Will go through all the programs linked together.
# "visited" is used to make sure to not visit 2 times
# the same program (to avoid infinite loop).
def findConnections(visited, current)
  queue = Array.new
  queue.push(current)

  while queue.size > 0
    prog = queue.pop
    if !visited.has_key?(prog.id)
      visited[prog.id] = 1
      prog.connections.each do |con|
        queue.push(con)
      end
    end
  end
end

# Contains all the programs
programs = Hash.new

input = File.open('input.txt', 'r')
input.each_line do |line|
  str = line.chomp.split(" <-> ")
  
  prog = programs.add?(str[0])
  
  connections = str[1].split(", ")
  
  connections.each do |con|
    otherProg = programs.add?(con)
    prog.connectTo(otherProg)
    otherProg.connectTo(prog)
  end
end
input.close

visited = Hash.new
findConnections(visited, programs["0"])
puts "Part 1: #{visited.size}"

visited = Hash.new
# Count the number of groups
count = 0

programs.each do |id, current|
  if visited.has_key?(id)
    next
  else
    count+=1
  end
  findConnections(visited, current)
end

puts "Part 2: #{count}"
