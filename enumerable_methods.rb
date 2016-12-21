module Enumerable

	def my_each
		i = 0
		while i < self.length
			yield self[i]
				i = i + 1
		end
	end

	def my_each_with_index
		i = 0
		while i < self.length
			yield self[i], i
				i = i + 1
		end
	end

	def my_select
		i = 0
		array = []
		while i < self.length
			if yield self[i]
				array.push(self[i])
			end
			i = i + 1
		end
		return array
	end

	def my_all?
		i = 0
		while i < self.length
			if yield self[i]
				i = i + 1
			else
				return false
			end
		end
		return true
	end

	def my_any?
		i = 0
		while i < self.length
			if yield self[i]
				return true
			end
			i = i + 1
		end
		return false
	end

	def my_none?
		i = 0 
		while i < self.length
			if yield self[i]
				return false
			else
				i = i + 1
			end
		end
		return true
	end

	def my_count
		return self.length
	end

	def my_map(proc=nil)
		i = 0
		array = []
		while i < self.length
			if !block_given?
				puts "one"
				array.push(proc.call(i))
			elsif proc.nil?
				puts "two"
				array.push(yield self[i])
			else
				puts "three"
				array.push(proc.call(yield self[i]))
			end
			i = i + 1
		end
		return array
	end

	def my_inject(initial=nil)
		i = 1
		if initial.nil?
			result = self[0]
		else
			result = initial
		end
		while i < self.length
			result = yield result, self[i]
			i = i + 1
		end
		return result
	end

	

end

def multiply_els(array)
		return array.my_inject { |mult, n| mult * n}
end

my_array = [1,2,3,4,5]
my_array.my_each { |num| puts num * 7 }
my_array.each { |num| puts num * 7 }


my_array.my_each_with_index { |num, index| puts "Num: #{num}   Index: #{index}"}
my_array.each_with_index { |num, index| puts "Num: #{num}   Index: #{index}"}

select1 = my_array.select { |num| num.even? }
puts select1.inspect
select2 = my_array.my_select { |num| num.even? }
puts select2.inspect

my_word_array = ["Dog", "Cat", "Bird", "Monkey"]
puts my_word_array.all? { |word| word.length >= 3 }
puts my_word_array.my_all? { |word| word.length >= 4 }
puts my_word_array.any? { |word| word.length >= 6 }
puts my_word_array.my_any? { |word| word.length >= 7 }
puts my_word_array.none? { |word| word.length >= 7 }
puts my_word_array.my_none? { |word| word.length >= 4 }

puts my_array.my_count
map = my_array.my_map { |num| num * 2 }
puts map.inspect

my_result = my_array.my_inject { |sum, n| sum + n }
puts my_result	

my_new_array = [2, 4, 6, 8, 10]
my_new_result = my_new_array.my_inject	{ |mult, n| mult * n}
puts my_new_result	

puts multiply_els([3,4,5])
my_proc = Proc.new {|num| num + 1 }
puts my_new_array.my_map(my_proc) { |num| num * 2 }