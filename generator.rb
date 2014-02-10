class Generator

	def initialize(wide,high,start_x,start_y,finish_x,finish_y)
		@wide = wide
		@high = high
		@maze = Maze.new(wide,high)
		@start = @maze.coordinate(start_x*2,start_y*2)
		@finish = @maze.coordinate(finish_x*2,finish_y*2)
	end

	def generate
		binary = generate_blank

	end

	def generate_blank
		binary = String.new
		(1..@wide*@high).each do |char|
			binary += "1"
		end
		(1..((@wide - 1)/ 2)).each do |w|
			(1..((@high - 1)/ 2)).each do |h|
				set(coordinate(w*2,h*2), "0")
			end
		end
		return binary
	end


end