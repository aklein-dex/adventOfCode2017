#!/usr/bin/env ruby

puts "--- Day 2: Corruption Checksum ---"

if ARGV[0] == "2"
    puts "--- Part 2:"
    part = 'part2'
else
    puts "--- Part 1:"
    part = 'part1'
end

# Return the difference bewteen the max and the min of the line
def part1(line)
    max = 0
    min = 99999
    numbers = line.split()
    numbers.each do |n|
        max = n.to_i if n.to_i > max
        min = n.to_i if n.to_i < min
    end
    return max - min
end

# Return the result of the division if one evenly divides the other.
# Sort the array to avoid to divide a smaller number by a bigger one.
def part2(line)
    numbers_str = line.chomp.split()
    numbers = numbers_str.map(&:to_i).sort

    # Start from the end
    i = numbers.size - 1

    while i > 0
        j = 0
        while j < i
            return numbers[i] / numbers[j] if numbers[i] % numbers[j] == 0
            j = j + 1
        end
        i = i - 1
    end
    return 0
end

result = 0

input = File.open('input.txt', 'r')
input.each_line do |line|
    result+= send(part, line)
end
input.close

puts result

