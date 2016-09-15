class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
  end

  def my_select(&prc)
    new_array = []
    self.my_each do |el|
      new_array << el if prc.call(el)
    end
    new_array
  end

  def my_reject(&prc)
    self.my_select do |el|
      !prc.call(el)
    end
  end

  def my_any?(&prc)
    self.my_each do |el|
      return true if prc.call(el)
    end
    false
  end

  def my_all?(&prc)
    self.my_each do |el|
      unless prc.call(el)
        return false
      end
    end
    true
  end

  def my_flatten
    flattened_array = []

    self.my_each do |el|
      if el.is_a? Array
        el.my_flatten.each do |el1|
          flattened_array << el1
        end
      else
        flattened_array << el
      end
    end

    flattened_array
  end

  def my_zip(*args)
    zipped = []

    self.my_each do |el|
      zipped << [el]
    end

    args.each do |arg|
      (0...zipped.length).each do |idx|
        zipped[idx] << arg[idx]
      end
    end

    zipped
  end

  def my_rotate(shift)
    shift = shift % self.length
    self[shift..-1] + self[0...shift]
  end

  def my_join(separator = '')
    result = ""

    self.my_each do |el|
      result << connector unless result.empty?
      result << el
    end

    result
  end

  def my_reverse
    reversed_array = []

    until self.empty?
      reversed_array << self.pop
    end

    reversed_array
  end
end

# puts (1..5).to_a.my_all? { |el| el < 3 }
# p [[1,2],3,[[4]]].my_flatten
a = [4]
b = [7,8]
p [1,2,3].my_zip(a,b)
# p ['a','b'].my_join()
# p (1..10).to_a.my_reverse
