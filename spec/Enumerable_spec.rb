require './main.rb'

describe Enumerable do
  let(:number) { [1, 2, 3, 4] }
  let(:string) { %w[cat bear rat] }

  describe '#my_each' do
    it 'enumerable when no block is given' do
      expect((1..4).my_each).to be_instance_of(Enumerator)
    end

    it 'should not modify an array' do
      expect((number.my_each { |x| x * x })).to match(number)
    end
  end

  describe '#my_each_with_index' do
    it 'enumerable when no block is given' do
      expect((1..4).my_each).to be_instance_of(Enumerator)
    end

    it 'returns an item and its index' do
      hash = {}
      %w[mufin pizza cake].my_each_with_index do |item, index|
        hash[item] = index
      end
      expect(hash).to include('mufin' => 0, 'pizza' => 1, 'cake' => 2)
    end
  end

  describe '#my_select' do
    it 'enumerable when no block is given' do
      expect((1..4).my_select).to be_instance_of(Enumerator)
    end

    it 'should return new array with selected values' do
      a = [1, 2, 3, 4, 5]
      b = a.my_select(&:odd?)
      expect(b).not_to eql(a)
    end

    it 'returns a new hash for which the block returns true' do
      options = { likes: 10, post: 'NIce post' }
      c = options[:likes]
      expect(c).to eql(10)
    end
  end

  describe '#my_all?' do
    it 'should return true if no block given' do
      expect([].my_all?).to eql(true)
    end

    it 'should return false if the block never return true' do
      expect([1, true, nil].my_all?).to eql(false)
    end

    it 'should return false unless the value is the same as pattern' do
      expect(string.my_all?(/take/)).to eql(false)
    end

    it 'should return false unless value matches the pattern' do
      expect([1, 2, 3].my_all? { |x| x > 2 }).to eql(false)
    end

    it 'return false if the value is not equal to pattern' do
      expect([3i, 4, 3].my_all?(Numeric)).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'should return true if the block provided is a value other than nil or false' do
      expect([1, false, nil].my_any?(Integer)).to eql(true)
    end

    it 'return false if the block did not return true' do
      expect(string.my_any?(/float/)).to eql(false)
    end

    it 'should return false unless the value is the same as pattern' do
      expect([1, false, nil].my_any?).to eql(true)
    end

    it 'should return true unless value matches the pattern' do
      expect([1, 2, 3].my_any? { |x| x > 2 }).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'return true if the block never return true for all the element provided' do
      expect(string.my_none? { |x| x.length < 3 }).to eql(true)
    end

    it 'should return true if the block is not passed' do
      expect([].my_none?).to eql(true)
    end

    it 'should return false if some of the value return true for the pattern' do
      expect(string.my_none?(/cat/)).to eql(false)
    end

    it 'should compare if the pattern is exactly equal to the given collection of an element and return false' do
      expect([true, false, nil].my_none?).to eql(false)
    end
  end

  describe '#my_count' do
    it 'returns number of element which matches the pattern' do
      expect(number.my_count { |x| x > 2 }).to eql(2)
    end

    it 'should count the number of items that yields to true value' do
      arr = [1, 2, 4, 2]
      expect(arr.my_count(&:even?)).to eql(3)
    end

    it 'returns zero if no argument is given' do
      expect([].my_count).to eql(0)
    end
  end

  describe '#my_map' do
    it 'should return new array with the result of current block for every element' do
      expect((1..4).my_map { |i| i + i }).to match([2, 4, 6, 8])
    end

    it 'enumerable when no block is given' do
      expect((1..4).my_map).to be_instance_of(Enumerator)
    end
  end

  describe '#my_inject' do
    it 'should return zero if no argument is given' do
      expect([].my_inject).to eql(0)
    end

    it 'return the sum of the element in the array' do
      expect(number.my_inject(0) { |total, x| total + x }).to eql(10)
    end

    it 'return the largest element from the string' do
      expect(string.my_inject { |memo, word| memo.size > word.size ? memo : word }).to eql('bear')
    end
  end
end
