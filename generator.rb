class Generator

	def initialize(wide,high)
		# Generators use actual coordinates and string positions, never logical coordinates
		@maze = Maze.new(wide,high)
		@wide = wide * 2 + 1
		@high = high * 2 + 1
	end

	def generate()
		# initialize a blank maze and call a recursive function to construct paths
		w = (@wide - 1) / 2
		h = (@high - 1) / 2
		str_pos = @maze.coordinate(rand(1..w)*2,rand(1..h)*2)

		generate_blank
		generate_recursive(str_pos)

		return @maze

	end

	def generate_recursive(str_pos)
		@maze.set(str_pos,"0")
		uuddllrr = @maze.uuddllrr(str_pos)
		dirs = Array.new
		done = true

		uuddllrr.each do |next_str_pos|
			# make sure there is at least one valid path from current cell, add it to a list of valid directions
			if @maze.get(next_str_pos) == "X"
				done = false
				dirs << uuddllrr.index(next_str_pos)
			end
		end
		return if done

		@maze.set(@maze.udlr(str_pos)[direction = dirs.sample],"0")
		if !generate_recursive(uuddllrr[direction])
			# when a recursive call has returned false, that path has finished
			# start a new path from the last valid position
			generate_recursive(str_pos)
		end
	end

	def generate_blank
		# make a grid of boxes for processing
		flat_string = "1" * (@wide*@high)

		(1..((@wide - 1)/ 2)).each do |w|
			(1..((@high - 1)/ 2)).each do |h|
				flat_string[@maze.coordinate(w*2,h*2)] = "X"
			end
		end

		@maze = Maze.new(@maze.width, @maze.height, flat_string)
		return flat_string
	end

end