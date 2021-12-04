#!/usr/bin/ruby
require 'pry-byebug'

module Enumerable
  def my_each(&block)
    return self.to_enum unless block_given?

    for i in self
      block.call(i)
    end
    return self
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


  def my_map(custom_proc = nil, &block)
    (block = custom_proc) unless custom_proc.nil?
    return self.to_enum if !block_given? && custom_proc.nil?

    map_array = []
    self.my_each { |i| map_array << block.call(i) }
    return map_array
  end


  def my_inject(arg = :default, &block)
    return self.to_enum unless block_given?

      (acc = self.first) if arg == :default
      (acc = arg) if arg != :default
      for i in self
        next if i == self.first && arg == :default

        acc = block.call(acc, i)
      end
      return acc
  end


  def my_select(&block)
    return self.to_enum unless block_given?

    selected = []
    self.my_each { |i| (selected << i) if block.call(i) }
    return selected
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


end
