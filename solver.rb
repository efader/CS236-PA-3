require_relative "maze"

class Solver
	def initialize(start_x,start_y,finish_x,finish_y,maze=Maze.new(1,1,"1"))
		@maze = maze
		@map = maze
		@start = maze.coordinate(start_x,start_y)
		@finish = maze.coordinate(finish_x,finish_y)
	end

	def solve(cell=@start)
		# simple recursive solution to check all paths
		done = false
		if cell == @finish
			return true
		else
			@map.set(cell,"X")
		end
		u = @maze.up(cell)
		d = @maze.down(cell)
		l = @maze.left(cell)
		r = @maze.right(cell)
		if @map.get(u) == "0"	
			done = done || solve(u)
		end
		if @map.get(d) == "0"
			done = done || solve(d)
		end
		if @map.get(l) == "0"
			done = done || solve(l)
		end
		if @map.get(r) == "0"
			done = done || solve(r)
		end
		return done
	end

	def trace(cell=@start)
		path = cell.to_s
		if cell == @start
			# on starting a new solution, refresh the map to cross off completed paths
			@map = @maze.clone
		elsif cell == @finish
			# this triggers all traces along the correct path to return strings instead of nil
			return path
		end
		@map.set(cell,"X")

		udlr = @maze.udlr(cell)

		udlr.each do |next_cell|
			if @map.get(next_cell) == "0"
				next_path = trace(next_cell)
				if !!next_path
					# if a path is returning a string instead of nil, return an appended string
					@map.set(cell,"o")
					return path + " " + next_path.to_s
				end
			end
		end
		return nil
			
	end

	def solution
		visual = @maze.visualize(@maze)
		
	end
end

maze = Maze.new(4,4,111111111100010001111010101100010101101110101100000101111011101100000101111111111)
solver = Solver.new(8,2,2,8,maze)
#puts solver.solve
solver.solution
puts solver.trace
solver.solution
