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
	array = (0..100).to_a.sample(5).uniq
	sample = array.sample
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

def dfs(array,value)
	bst = build_tree(array)
	stack = [bst.first]
	marked = [nil, bst.first]
	result = bst.first
	catch(:result) do
		until result.value == value
			until marked.include?(stack.last.left_child) && marked.include?(stack.last.right_child)
				if stack.last.left_child != nil && !marked.include?(stack.last.left_child)
						left_child = stack.last.left_child
						stack << left_child
						result = left_child
						marked << left_child
						throw :result if result.value == value
				elsif stack.last.right_child != nil && !marked.include?(stack.last.right_child)
						right_child = stack.last.right_child
						stack << right_child
						result = right_child
						marked << right_child
						throw :result if result.value == value
				end
			end
			stack.delete(stack.last)
		end
	end
	result.value == value ? (p result) : (p nil)
end

def dfs_rec(built_tree,value,node=built_tree.first, marked=[nil,built_tree.first])
	return p node if node.value == value
	return p nil if marked.include?(built_tree)

	if node.left_child != nil && !marked.include?(node.left_child)
		marked << node.left_child
		dfs_rec(built_tree,value,node.left_child, marked)
	elsif node.right_child != nil && !marked.include?(node.right_child)
		marked << node.right_child
		dfs_rec(built_tree,value,node.right_child, marked)
	else
		dfs_rec(built_tree,value,node.parent, marked)
	end
end

array = (0..100).to_a.sample(10).uniq
sample = array.sample
p array,sample
x = bfs(array,sample)
y = dfs(array,sample)
z = dfs_rec(build_tree(array),sample)

a = x.value == y.value
b = x.value == z.value
p a == b