class Maze
	# mazes are defined by their width and height
	# this describes a square of spaces that are all open
	# these open spaces can have either walls or paths to other
	# open
	def initialize(wide, high, binary = String.new)
		@wide = wide * 2 + 1
		@high = high * 2 + 1
		@binary = binary
	end

		def coordinate(x, y)
		# translate logical coordinates to string position
		# set a min and max value for coordinates according to open spaces
		x = (x <= (@wide)) ? x : @wide
		x = (x >= 1) ? x : 1
		y = (y <= (@high)) ? y : @high
		y = (y >= 1) ? y : 1
		return (@wide) * (@high - y) + x - 1
	end

	def get_x(num)
		x = (num + 1) % @wide
		x = (x==0) ? 7 : x
		return x
	end
	def get_y(num)
		return @high - (num) / @wide
	end
	def left(x,y)
		return coordinate(x-1,y)
	end
	def right(x,y)
		return coordinate(x+1,y)
	end
	def up(x,y)
		return coordinate(x,y+1)
	end
	def down(x,y)
		return coordinate(x,y-1)
	end

	def generate
		@binary = ""
		(1..@wide*@high).each do |char|
			@binary += "1"
		end
		(1..((@wide - 1)/ 2)).each do |w|
			(1..((@high - 1)/ 2)).each do |h|
				@binary[coordinate(w*2,h*2)] = "0"
			end
		end
		return @binary
	end
	
	def print(input=@binary)
		(1..@high).each do |line|
			puts input[((line-1)*@wide)..((line)*@wide-1)]
		end
	end

	def visualize
		visual = String.new(@binary)
		(0..((@wide)*(@high)-1)).each do |char|

			if @binary[char].to_s == "0"
				visual[char] = " "
			else
				x = get_x(char)
				y = get_y(char)
				neighbors = @binary[left(x,y)].to_i+@binary[right(x,y)].to_i+@binary[up(x,y)].to_i+@binary[down(x,y)].to_i
				neighbors = @binary[left(char)].to_i+@binary[right(char)].to_i+@binary[up(char)].to_i+@binary[down(char)].to_i
				if neighbors >= 4
					visual[char] = "+"
				elsif ((@binary[left(x,y)].to_i + @binary[right(x,y)].to_i) >= 2)
					visual[char] = "-"
				else
					visual[char] = "|"
				end
				#puts char.to_s + " is at position (" + x.to_s + ", " + y.to_s + "). left-right-up-down: " + @binary[left(x,y)]+" "+@binary[right(x,y)]+" "+@binary[up(x,y)]+" "+@binary[down(x,y)]
			end
		end
		return visual
	end

end

maze = Maze.new(4,5)
maze.generate
maze.print
puts ""
maze.print(maze.visualize)
puts ""




