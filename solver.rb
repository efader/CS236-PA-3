require_relative "maze"

class Solver
	def initialize(maze=Maze.new(1,1,"1"))
		@maze = maze
	end

	def solve(cell=@start)
	end

	def trace(start_x,start_y,finish_x,finish_y)
		@map = Maze.new(@maze.width, @maze.height, @maze.value)
		start = @maze.coordinate(start_x*2,start_y*2)
		finish = @maze.coordinate(finish_x*2,finish_y*2)
		puts start
		puts finish
		return trace_recursive(start,finish)
		
	end

	def trace_recursive(cell, finish)
		path = cell.to_s
		puts "Current cell is (" + @map.get_x(cell).to_s + "," + @map.get_y(cell).to_s + ")"
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
					#@map.set(cell,"o")
					return path + " " + next_path
				end
			end
		end
		return nil
			
	end

	def solution
		#visual = @maze.visualize(@maze)
		
	end
end

maze = Maze.new(4,4,111111111100010001111010101100010101101110101100000101111011101100000101111111111)
#maze.print(maze.visualize)
#maze.print
solver = Solver.new(maze)
puts solver.trace(4,1,1,4)
