class Solver
	def initialize(maze=Maze.new(1,1,"1"))
		@maze = maze
		@current_solution = String.new
	end

	def solve(x1,y1,x2,y2)
		return !!trace(x1,x2,y1,y2)
	end

	def trace(start_x,start_y,finish_x,finish_y)
		# make a copy of the maze to mark up
		@map = Maze.new(@maze.width, @maze.height, String.new(@maze.value))

		start = @maze.coordinate(start_x*2,start_y*2)
		finish = @maze.coordinate(finish_x*2,finish_y*2)
		# call a recursive function to process the copy of the maze
		@current_solution = trace_recursive(start,finish)
		@map = Maze.new(@maze.width, @maze.height, @maze.value)

		return @current_solution
		
	end

	def trace_recursive(cell, finish)
		path = cell.to_s
		if cell == finish
			# this triggers all traces along the correct path to return strings instead of nil
			return path
		end
		@map.set(cell,"X")

		udlr = @map.udlr(cell)

		udlr.each do |next_cell|
			if @map.get(next_cell) == "0"
				next_path = trace_recursive(next_cell,finish)
				if !!next_path
					# if a path is returning a string instead of nil, return an appended string
					return path + " " + next_path
				end
			end
		end
		return nil		
	end

	def solution
		# list logical coordinates for how to solve the maze
		solution = String.new
		@current_solution.split.each do |step|
			x = @maze.get_x(step.to_i)
			y = @maze.get_y(step.to_i)
			if (x % 2 == 0) && (y % 2 == 0)
				solution = solution + "(" + (x / 2).to_s + "," + (y / 2).to_s + ")>"
			end
		end
		return solution
	end

	def visual_solution
		# Draw the path that trace generated onto the visualization of the maze
		visual = String.new(@maze.visualize)
		@current_solution.split.each do |step|
			visual[step.to_i] = "*"
		end
		return visual
	end
end
