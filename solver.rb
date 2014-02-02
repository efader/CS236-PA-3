require_relative "maze"

class Solver
	def initialize(start_x,start_y,finish_x,finish_y,maze=Maze.new(1,1,"1"))
		@maze = maze
		@map = maze
		@start = maze.coordinate(start_x,start_y)
		@finish = maze.coordinate(finish_x,finish_y)
	end

	def solve(cell=@start)
		done = false

		if cell == @finish
			return true
		else
			@map.set(cell,"X")
		end

		if (u = @maze.up(cell)) == 0
			done = done || solve(u)
		end

		if (d = @maze.down(cell)) == 0
			done = done || solve(d)
		end

		if (l = @maze.left(cell)) == 0
			done = done || solve(l)
		end

		if (r = @maze.right(cell)) == 0
			done = done || solve(r)
		end

		return done

	end

	def progress
		@map.print
	end
end

maze = Maze.new(4,4,111111111100010001111010101100010101101110101100000101111011101100000101111111111)
solver = Solver.new(8,2,2,8,maze)
puts solver.solve
solver.progress
