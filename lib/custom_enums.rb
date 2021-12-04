#!/usr/bin/ruby
require 'pry-byebug'

module Enumerable
  def my_inject(acc = self[0], &block)
    return self.to_enum unless block_given?
    for i in self
      next if i == self[0]
      acc = block.call(acc, i)
    end
    return acc
  end

  def my_map(custom_proc = nil, &block)
    (block = custom_proc) unless custom_proc.nil?
    return self.to_enum if !block_given? && custom_proc.nil?
    map_array = []
    self.my_each { |i| map_array << block.call(i) }
    return map_array
  end

  def my_count(item = :Default, &block)
    (block = proc { |i| i == item }) if item != :Default
    (block = proc { |i| i == i }) if !block_given? && item == :Default
    count = 0
    self.my_each { |i| (count += 1) if block.call(i) }
    return count
  end

  def my_none?(&block)
    (block = proc { |i| i }) unless block_given?

    self.my_each { |i| return false if block.call(i) }
    return true
  end

  def my_any?(&block)
    (block = proc { |i| i }) unless block_given?

    self.my_each { |i| return true if block.call(i) }
    return false
  end

  def my_all?(&block)
    (block = proc { |i| i }) unless block_given?

    self.my_each { |i| return false unless block.call(i) }
    return true
  end

  def my_select(&block)
    return self.to_enum unless block_given?

    selected = []
    self.my_each { |i| (selected << i) if block.call(i) }
    return selected
  end

  def my_each_with_index(&block)
    return self.to_enum unless block_given?

    j = 0
    for i in self
      block.call(i, j)
      j += 1
    end
    return self
  end

  def my_each(&block)
    return self.to_enum unless block_given?

    for i in self
      block.call(i)
    end
    return self
  end
end

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
