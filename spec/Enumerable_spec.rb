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