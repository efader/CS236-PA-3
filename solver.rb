require_relative "maze"

class Solver
	def initialize(maze=Maze.new(1,1,"1"))
		@maze = maze
		@current_solution = String.new
	end

	def solve(x1,y1,x2,y2)
		return !!trace(x1,x2,y1,y2)
	end

	def trace(start_x,start_y,finish_x,finish_y)
		@map = Maze.new(@maze.width, @maze.height, @maze.value)

		start = @maze.coordinate(start_x*2,start_y*2)
		finish = @maze.coordinate(finish_x*2,finish_y*2)

		@map = Maze.new(@maze.width, @maze.height, @maze.value)

		@current_solution = trace_recursive(start,finish)
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
				#puts next_path.to_s + " tracing " + next_cell.to_s
				if !!next_path
					# if a path is returning a string instead of nil, return an appended string
					return path + " " + next_path
				end
			end
		end
		return nil
			
	end

	def solution
		solution = String.new
		@current_solution.split.each do |step|
			x = @maze.get_x(step)
			y = @maze.get_y(step)
			if (x % 2 == 0) && (y % 2 == 0)
				solution = solution + "(" + (x / 2).to_s + "," + (y / 2).to_s + ") "
			end
		end

	end

	def print_solution
		visual = String.new(@maze.visualize)
		@current_solution.split.each do |step|
			visual[step.to_i] = "*"
		end
		return @maze.print(visual)
	end
end

maze = Maze.new(4,4,111111111100010001111010101100010101101110101100000101111011101100000101111111111)
solver = Solver.new(maze)
puts solver.solve(1,4,4,1)
solver.print_solution
puts solver.solution

