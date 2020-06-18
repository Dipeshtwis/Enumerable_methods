module Enumerable
  def my_each
    i = 0
    while i < length
      yield(self[i])
      i += 1

    end
    self
  end

  def my_each_with_index
    i = 0
    while i < length
      yield(self[i], i)
      i += 1

    end
    self
  end

  def my_select
    selected_item = []
    my_each do |i|
      selected_item.push(i)
    end
    selected_item
  end

  def my_all?
    my_each do |i|
      return false if yield(i) == false
    end
    true
  end

  def my_any?
    my_each do |i|
      return true if yield(i) == true
    end
    false
  end

  def my_none?
    my_each do |i|
      return false if yield(i) == true
    end
    true
  end

  def my_count?
    count = 0
    my_each do |i|
      count += 1 if yield(i) == true
    end
    count
  end

  def my_map
    items = []
    my_each do |i|
      proc.nil? ? items << proc.call(i) : items << yield(i)
    end
    items
  end

  def my_inject(first = self[0])
    my_each do |i|
      first = yield(first, i)
    end
    first
  end
end

arr = [2, 4, 5]
arr.my_each { |i| p i }
arr.my_each_with_index { |val, i| p "#{val} in index #{i}" }
p arr.my_select { |i| }
p (arr.my_all? { |i| i > 3 })
p (arr.my_any? { |i| i > 10 })
p (arr.my_none? { |i| i > 9 })
p (arr.my_count? { |i| i > 3 })
p arr.my_inject(0) { |total, i| total + i }

def multiply_els(arr)
  arr.my_inject(1) { |total, i| total * i }
end

p multiply_els(arr)

p (arr.my_map { |i| i + 5 })
my_proc = proc.new { |i| i**3 }
p arr.my_map(&my_proc)
