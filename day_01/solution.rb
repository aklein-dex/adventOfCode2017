#!/usr/bin/env ruby

puts "--- Day 1: Inverse Captcha ---"

# Read the single line of the file and chomp it
captcha = File.open('input.txt', &:readline).chomp

result = 0

if ARGV[0] == "2"
    puts "--- Part 2:"
    # Just loop half of the list and then multiply by 2 the result
    half = captcha.size/2
    for i in 0..half 
        result+=captcha[i].to_i  if captcha[i] == captcha[i + half]
    end
    result = result * 2

else
    puts "--- Part 1:"

    # Need the last character because the list is circular
    last = captcha[-1]

    captcha.split("").each do |x|
        result+=x.to_i if x == last
        last = x
    end
end


puts result
