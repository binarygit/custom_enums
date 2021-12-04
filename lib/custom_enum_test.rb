#!/usr/bin/ruby
require './lib/custom_enums'

array = [1, 2, 3, 6]

puts 'testing each'
p array.each { |item| item } == array.my_each { |item| item }
puts

puts 'testing each_with_index'
p array.each_with_index { |i, idx| "#{idx}) #{i}" } == array.my_each_with_index { |i, idx| "#{idx}) #{i}" }
puts

puts 'testing select'
p array.select { |i| i == 3 } == array.my_select { |i| i == 3 }
puts

puts 'testing all?'
p array.all? { |i| i > 4 } == array.my_all? { |i| i > 4 }
p array.all? == array.my_all?
p [nil, true, 99].all? == [nil, true, 99].my_all?
p [].all? == [].my_all?
puts

puts 'testing any?'
p array.any? { |i| i > 4 } == array.my_any? { |i| i > 4 }
p array.any? == array.my_any?
puts

puts 'testing count'
p array.count { |i| i < 3 } == array.my_count { |i| i < 3 }
p array.count == array.my_count
p array.count(2) == array.my_count(2)
nilarray = [nil, nil]
p nilarray.count == nilarray.my_count
puts

puts 'testing map'
p array.map { |i| i + 1 } == array.my_map { |i| i + 1 }
block = proc { |i| i + 1 }
p array.my_map(block)
puts

puts 'testing inject'
p array.inject { |acc, value| acc + value } == array.my_inject { |acc, value| acc + value }
p array.inject { |acc, value| acc * value } == array.my_inject { |acc, value| acc * value }
p array.inject(0) { |acc, value| acc * value } == array.my_inject(0) { |acc, value| acc * value }
p array.inject(2) { |acc, value| acc * value } == array.my_inject(2) { |acc, value| acc * value }
