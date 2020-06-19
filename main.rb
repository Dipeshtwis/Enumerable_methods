module Enumerable
  def my_each
    return to_enum if block_given? == false
    i = 0
    while i < length
      yield(self[i])
      i += 1

    end
    self
  end

  def my_each_with_index
    return to_enum if block_given? == false
    i = 0
    while i < length
      yield(self[i], i)
      i += 1

    end
    self
  end

  def my_select
    return to_enum if block_given? == false
    selected_item = []
    my_each do |i|
      selected_item.push(i)
    end
    selected_item
  end

  def my_all?(args = nil)
    index = 0
    array = to_a
    while index < array.size
      if block_given? == true
        return false unless yield(array[index])
      elsif args.class == Class
        return false unless array[index].class.ancestors.include? args
      elsif args.class == Regexp
        return false unless array[index] =~ args
      elsif args.nil? == true
        return false unless array[index]
      else
        return false unless args[index] == array[index]
      end
      index += 1
    end
    true
  end

  def my_any?(args = nil)
    index = 0
    array = to_a
    while index < array.size
      if block_given? == true
        return true if yield(array[index])
      elsif args.class == Class
        return true if array[index].class.ancestors.include? args
      elsif args.class == Regexp
        return true if array[index] =~ args
      elsif args.nil? == true
        return true if array[index]
      elsif args == array[index]
        return true
      end
      index += 1
    end
    false
  end
  def my_none?(args = nil)
    index = 0
    array = to_a
    while index < array.size
      if block_given? == true
        return false if yield (array[index])
      elsif args.class == Class
        return false if array[index].class.ancestors.include? args
      elsif args.class == Regexp
        return false if array[index] =~ args
      elsif args.nil? == true
        return false if array[index]
      elsif args[index] == array[index]
        return false
      end

      index += 1
    end
    true
  end
  def my_count(args = '')
    array = to_a
    index = 0
    count = 0
    if block_given? == false
      while index < array.size
        if args != ''
          count += 1 if array[index] == args
        else
          count += 1
        end
        index += 1
      end
    else
      while index < array.size
        count += 1 if yield(array[index])
        index += 1
      end
    end
    count
  end

  def my_map(&proc)
    return to_enum if block_given? == false

    i = 0
    ar = to_a
    array = []
    while i < ar.size
      array << if block_given?
        yield(ar[i])
          else
          proc.call(ar[i])
        end
      i += 1
    end
    array
  end

  
  def my_inject(*args)
    i = 0
    ar = to_a
    injector_result = 0
    if args[1].nil? && !block_given?
      symbol = args[0]
    elsif args[1].nil? && block_given?
      injector_result = args[0]
    else
      injector_result = args[0]
      symbol = args[1]
    end
    injector_result = 0 if args.empty?

    while i < ar.size
      injector_result = if symbol
                          injector_result.send(symbol, ar[i])
                        else
                          yield(injector_result, ar[i])
                        end
      i += 1
    end

    injector_result
  end
end

arr = [2, 4, 5]
arr.my_each { |i| p i }
arr.my_each_with_index { |val, i| p "#{val} in index #{i}" }
p(arr.my_select { |i| })
p(arr.my_all? { |i| i > 3 })
p(arr.my_any? { |i| i > 10 })
p(arr.my_none? { |i| i > 9 })
p(arr.my_count { |i| i > 3 })
p arr.my_inject(0) { |total, i| total + i }

def multiply_els(arr)
  arr.my_inject(1) { |total, i| total * i }
end

p multiply_els(arr)

p(arr.my_map { |i| i + 5 })
my_proc = proc.new { |i| i**3 }
p arr.my_map(&my_proc)
