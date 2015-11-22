class Node
	attr_accessor :parent, :child
	attr_reader :value 
	def initialize(value, parent=nil, child=[])
		@value = value
	end
end

def build_tree(array)
	y = []
	array.each { |x| y << Node.new(x)}
	y.each_with_index do |z, index| 
		index == 0 ? z : compare(y[index - 1], z)
	end
end

def compare(one, two)
	if one.child.nil?
		if one.value > two.value
			one.child << two
			two.parent = one
			p one.child
		elsif two.value > one.value
			#two.child << one
			one.parent = two
		end
	elsif one.child == 1
		p "hi"
	else
		compare(one.child, two)
	end
end

build_tree([1,2,3,4,5])