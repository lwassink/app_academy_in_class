def factors(num)
  (1..num).select { |x| num % x == 0 }
end

class Array
  def bubble_sort!(&prc)
    sorted = false

    until sorted
      sorted = true
      (0...self.length-1).each do |idx1|
        idx2 = idx1 + 1
        if prc.call(self[idx1],self[idx2]) == 1
          self[idx1], self[idx2] = self[idx2], self[idx1]
          sorted = false
        end
      end
    end

    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end
end

def substrings(string)
  substring_array = []
  string.chars.each_index do |start_idx|
    (start_idx...string.length).each do |end_idx|
      substring_array << string[start_idx..end_idx]
    end
  end
  substring_array.uniq
end

def subwords(word,dictionary)
  substrings(word).select {|sub| dictionary.include?(sub)}
end

# p factors(12)
# p [5,3,4,8,7].bubble_sort {|num1, num2| num1 <=> num2}
# p substrings("cata")
p subwords("hithere",['hi', 'there','cat'])
