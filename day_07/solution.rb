#!/usr/bin/env ruby

puts "--- Day 7: Recursive Circus ---"


class Program
  attr_accessor :parent, :name, :value, :child
  
  def initialize(name, value)
    @name   = name
    @value  = value
    @parant = nil
    @child  = Array.new
  end
  
  def addChild(prog)
    @child << prog
  end
  
end

programs = Hash.new

input = File.open('input.txt', 'r')
input.each_line do |line|
    elements = line.split(" ")
    name  = elements[0]
    value = elements[1].tr("()","").to_i
    
    if programs.has_key?(name)
      # it was added as a child with a valud of 0,
      # so we just need to update the value
      programs[name].value = value
    else
      programs[name] = Program.new(name, value)
    end
    
    i = 3
    while elements[i]
      childName = elements[i].tr(",","")
      
      if programs.has_key?(childName)
        child = programs[childName]
      else
        child = Program.new(childName, 0)
        programs[childName] = child
      end
      programs[name].addChild(child)
      child.parent = programs[name]
      i+=1
    end
end
input.close

# Find the parent process
root = programs.values[0]
while root.parent != nil
  root = root.parent
end

puts "Part 1: Bottom program is #{root.name}"

# For part 2
def adjustWeight(current)
  
  if current.child.size == 0
    return current.value
  else
    values = []
    current.child.each do |c|
      values << adjustWeight(c)
    end
    if values.uniq.length > 1
      diff = values.uniq[0] - values.uniq[1]
      # I know that the first element is the one we should change
      puts "Part 2: weight should be #{current.child[0].value - diff}"
      exit
    end
    
    return values.inject(0) {|sum,x| sum + x } + current.value
  end
end 

adjustWeight(root)
