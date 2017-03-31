require 'byebug'

class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value)
    @parent, @children, @value = nil, [], value
  end

  def parent=(node)
    if node.nil?
      @parent = nil
    else
      @parent.children.delete(self) unless @parent.nil?
      @parent = node
      node.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise 'Node is not a child' unless @children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target)
    return self if @value == target
    @children.each do |child|
      result = child.dfs(target)
      return result unless result.nil?
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      test = queue.shift
      if test.value == target
        return test
      else
        queue.concat(test.children)
      end
    end
    nil
  end

end
