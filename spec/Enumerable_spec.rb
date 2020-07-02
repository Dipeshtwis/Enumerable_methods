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

describe '#my_all' do
  it 'should return true if no block given' do
    expect([].my_all?).to eql(true)
  end

  it 'should return false if the block never return true' do
    expect([1, true, nil].my_all?).to eql(false)
  end

  it 'should return false unless the value is the same as pattern' do
    expect(["ram", "bear", "three"].my_all?(/take/)).to eql(false)
  end

  it 'should return false unless value matches the pattern' do
    expect([1,2,3].my_all?{ |x| x > 2}).to eql(false)
  end

  it 'return false if the value is not equal to pattern' do
    expect([3i, 4, 3].my_all?(Numeric)).to eql(true)
  end
end
end