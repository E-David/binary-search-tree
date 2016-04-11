class Node
	attr_accessor :parent, :left_child, :right_child
	attr_reader :value
	def initialize(value, parent=nil, left_child=nil, right_child=nil)
		@value = value
		@parent = parent
		@left_child = left_child
		@right_child = right_child
	end

		# Put all instance variables of a node in an easily read string
	def to_s
		str = ""
		str += "Node: #{@value}"
		str += " | @parent: #{@parent.value}" if !@parent.nil?
		str += " | @left_child: #{@left_child.value}" if !@left_child.nil?
		str += " | @right_child: #{@right_child.value}" if !@right_child.nil?
		str
	end

end

def build_tree(array)
	root = Node.new(array[0])
	arr = Array.new
	array.each_with_index do |num, index| 
		index == 0 ?  arr << root : arr << link(root,num)
	end
	arr
end

def link(node, num)
	if num < node.value
		if node.left_child.nil?
			node.left_child = Node.new(num, node)
		else
			link(node.left_child, num)
		end
	elsif num > node.value
		if node.right_child.nil?
			node.right_child = Node.new(num, node)
		else
			link(node.right_child, num)
		end
	else
		return node
	end
end

def build_tree_test
	array = (0..100).to_a.sample(5).uniq
	sample = array.sample
end

def bfs(array, value)
	bst = build_tree(array)
	queue = [bst.first]
	until queue.empty?
		current = queue.shift
		return current if current.value == value
		queue << current.left_child unless current.left_child.nil?
		queue << current.right_child unless current.right_child.nil?
	end
	nil
end

def dfs(array,value)
	bst = build_tree(array)
	stack = [bst.first]
	until stack.empty?
		current = stack.pop
		return current if current.value == value
		stack << current.left_child unless current.left_child.nil?
		stack << current.right_child unless current.right_child.nil?
	end
	nil
end
=begin
TODO: Improve recursive dfs
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
=end
array = (0..100).to_a.sample(10).uniq
sample = array.sample
puts "array to sort: #{array}"
puts "root: #{array.first}"
x = bfs(array,sample)
y = dfs(array,sample)
#z = dfs_rec(build_tree(array),sample)

a = x.value == y.value
p a
x = build_tree(array)
x.each {|y| puts y.to_s}
#b = x.value == z.value
#p a == b