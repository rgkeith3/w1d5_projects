require_relative '00_tree_node'

DELTA = [
  [-2,-1],
  [-2,1],
  [-1,-2],
  [-1,2],
  [1,-2],
  [1,2],
  [2,-1],
  [2,1]
]


class KnightPathFinder


  def initialize(position = [0,0])
    @position = position
    @root = PolyTreeNode.new(position)
    @visited_positions = [position]
    build_move_tree

  end

  def self.valid_moves(pos)
    result = []
    DELTA.each do |del|
      result << [pos[0] + del[0], pos[1] + del[1]]
    end
    result.select{|pos| pos.all?{ |el| el.between?(0,7) } }
  end

  def new_moves_positions(pos)
    remaining_new = KnightPathFinder.valid_moves(pos) - @visited_positions
    @visited_positions.concat(remaining_new)
    remaining_new
  end

  def build_move_tree
    queue = [@root]
    until queue.empty?
      current_node = queue.shift
      new_moves_positions(current_node.value).each do |pos|
        child = PolyTreeNode.new(pos)
        current_node.add_child(child)
        queue << child
      end
    end
  end

  def find_path(end_pos)
    target = @root.dfs(end_pos)
    trace_path(target).map(&:value)
  end

  def trace_path(target)
    return [target] if target.parent.nil?
    trace_path(target.parent) << target
  end

end

kpf = KnightPathFinder.new
p kpf.find_path([7, 6]) == [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) == [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
