require_relative "maze"
puts "Here's the sample maze"
maze = Maze.new(4,4,111111111100010001111010101100010101101110101100000101111011101100000101111111111)
maze.print(maze.visualize)
puts############
puts "Let's solve the sample maze:"
s = Solver.new(maze)
s.trace(4,1,1,4)
s.print
puts############
puts "Now let's redesign the maze:"
maze.redesign
maze.print(maze.visualize)
maze = Maze.new(30,10)
maze.redesign
puts############
puts "Here's a bigger maze:"
maze.print(maze.visualize)
s = Solver.new(maze)
s.trace(1,1,30,10)
puts############
puts "And the solution:"
s.print