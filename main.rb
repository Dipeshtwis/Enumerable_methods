  module Enumerable
    def my_each
      i = 0
      while i < self.length
      	yield(self[i])
      	i+=1
      	
      end
      self
    end

    def my_each_with_index
      i = 0
      while i < self.length
        yield(self[i], i)
      	i+=1

      end
      self
    end

    def my_select
      selected_item = []
      self.my_each do |i|
      	selected_item.push(i)
      	
      end
      selected_item
    end

    def my_all?
      self.my_each do |i|
        if yield(i) == false
          return false
        	
        end
      end
      true
    end

  end

  arr = [2, 4, 5]
  arr.my_each {|i| p i }
  arr.my_each_with_index {|val, i| p "#{val} in index #{i}"}
  p arr.my_select {|i| }
  p arr.my_all? {|i| i > 3}