class Generator

	def initialize(wide,high)
		@wide = wide * 2 + 1
		@high = high * 2 + 1
		@maze = Maze.new(wide,high)
	end

	def generate()
		w = (@wide - 1) / 2
		h = (@high - 1) / 2
		finish = @maze.coordinate(rand(1..w)*2,rand(1..h)*2)
		generate_blank

		generate_recursive(finish)

		return @maze

	end

	def generate_recursive(cell)
		@maze.set(cell,"0")
		udlr = @maze.udlr(cell)
		uuddllrr = @maze.uuddllrr(cell)

		done = true
		uuddllrr.each do |box|
			done = done && @maze.get(box) != "X"
			#puts box.to_s + " (" + (@maze.get_x(box) / 2).to_s + "," + (@maze.get_y(box)/2).to_s + ")"
		end

		if done
			return false
		end

		while @maze.get(uuddllrr[num=rand(0..3)]) != "X"
		end

		@maze.set(udlr[num],"0")
		if !generate_recursive(uuddllrr[num])
			generate_recursive(cell)
		end

		
	end

	def generate_blank
		# make a grid of boxes
		(0..@wide*@high-1).each do |char|
			@maze.set(char,"1")
		end
		(1..((@wide - 1)/ 2)).each do |w|
			(1..((@high - 1)/ 2)).each do |h|
				@maze.set(@maze.coordinate(w*2,h*2), "X")
			end
		end
		return @maze.value
	end


end