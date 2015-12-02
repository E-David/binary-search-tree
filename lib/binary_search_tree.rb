class Node
	attr_accessor :parent, :left_child, :right_child
	attr_reader :value
	def initialize(value)
		@value = value
		@parent = parent if @parent != nil
		@left_child = left_child if @left_child != nil
		@right_child = right_child if @right_child != nil
	end
end

def build_tree(array)
	y = []
	array.each { |x| y << Node.new(x)}
	y.each_with_index do |z, index| 
		index == 0 ? z : first_compare(z, y[0])
	end
=begin
	y.each do |x| 
	puts "#{x.value}:"
	puts " parent is #{x.parent.value}" if x.parent
	puts " left_child is #{x.left_child.value}" if x.left_child 
	puts " right_child is #{x.right_child.value}" if x.right_child
	end
=end
end

def first_compare(two, key)
	if key.value > two.value
		key.left_child.nil? ? begin key.left_child = two ; two.parent = key end : compare(key.left_child, two)
	else
		key.right_child.nil? ? begin key.right_child = two ; two.parent = key end : compare(key.right_child, two)
	end
end

def compare(one, two)
	if one.value > two.value
		one.left_child.nil? ? begin one.left_child = two ; two.parent = one end : compare(one.left_child, two)
	elsif one.value < two.value
		one.right_child.nil? ? begin one.right_child = two ; two.parent = one end : compare(one.right_child, two)
	end
end

def build_tree_test
	array = (0..100).to_a.sample(10).uniq
	sample = array.sample
	p array,sample
	bfs(array,sample)
end

def bfs(array, value)
	bst = build_tree(array)
	queue = [bst.first]
	result = bst.first
	until queue.size == 0 || result.value == value
		queue.each do |z|
			if z.left_child != nil || z.right_child != nil
				if z.left_child != nil
					queue << z.left_child
					result = z.left_child
				end
				break if result.value == value
				if z.right_child != nil
					queue << z.right_child
					result = z.right_child
				end
				break if result.value == value
				queue.delete(z)
			else
				queue.delete(z)
			end
		end
	end
	result.value == value ? (p result) : (p nil)
end

build_tree_test