require 'benchmark'

def range_rec(start, last)
  return [] if last < start

  range_rec(start, last - 1) + [last]
end

def range_itr(start, last)
  return [] if last < start

  (start..last).to_a
end

def exp1(base, exponent)
  return 1 if exponent == 0

  base * exp1(base, exponent - 1)
end

def exp2(base, exponent)
  return 1 if exponent == 0
  return base if exponent == 1

  return exp2(base, exponent / 2) ** 2 if exponent.even?
  base * (exp2(base, (exponent - 1) / 2)) ** 2
end

class Array
  def deep_dup
    dup_array = []

    self.each do |el|
      if el.is_a?(Array)
        dup_array << el.deep_dup
      else
        dup_array << el.dup
      end
    end

    deep_dup
  end
end

def fibonacci(num)
  return [] if num <= 0
  return [1] if num == 1
  return [1,1] if num == 2

  fib_previous = fibonacci(num - 1)
  fib_previous + [fib_previous[-1] + fib_previous[-2]]
end

def bsearch(array, target)
  return nil if array.empty?

  mid_idx = array.length / 2
  mid_val = array[mid_idx]
  return mid_idx if mid_val == target

  if mid_val > target
    bsearch(array[0...mid_idx],target)
  else
    right_search = bsearch(array[mid_idx+1..-1], target)
    if right_search.nil?
      nil
    else
      right_search + mid_idx + 1
    end
  end
end

def merge_sort(array)
  return array if array.length <= 1

  mid_idx = array.length / 2
  sorted_left = merge_sort(array[0...mid_idx])
  sorted_right = merge_sort(array[mid_idx..-1])
  merge_helper(sorted_left, sorted_right)
end

def merge_helper(array1, array2)
  merged_array = []
  until array1.empty? && array2.empty?

    if array2.empty? || (!array1.empty? && array1.first < array2.first)
      merged_array << array1.shift
    else
      merged_array << array2.shift
    end
  end
  merged_array
end

def subsets(array)
  return [[]] if array.empty?

  smaller_array = subsets(array[0..-2])
  last = [array.last]

  subset_array = smaller_array.map do |el|
    el + last
  end

  smaller_array + subset_array
end

def greedy_make_change(amount, coins = [25, 10, 5, 1])
  return [amount] if coins.include?(amount)

  big_coin = coins.find {|coin| coin < amount}
  [big_coin] + greedy_make_change(amount - big_coin, coins)
end

def make_change(amount, coins = [25, 10, 5, 1])
  return [] if amount <= 0
  return [amount] if coins.include?(amount)

  good_coins = coins.select { |coin| coin < amount }
  return nil if good_coins.empty?

  shortest_option = nil

  good_coins.each_with_index do |coin, idx|
    option = [coin] + make_change(amount - coin, good_coins.drop(idx))
    shortest_option = option if shortest_option.nil?
    shortest_option = option if shortest_option.length > option.length
  end

  shortest_option
end

