require_relative "solver"
require_relative "generator"

class Maze
	# The maze can be described in therms of logical coordinates, actual coordinates, and string position
	# 	logical coordinates describe a users perception of the maze as a grid of cells
	# 	actual coordinates include walls between logical cells
	# 	string positions refer to characters in a flat string representation
	# Most of the functions in the maze class deal with converting between these systems
	def initialize(wide=1, high=1, binary = "X")
		# logical dimensions are different than actual dimensions
		@wide = wide * 2 + 1
		@high = high * 2 + 1
		# default to an empty string of the correct size
		@binary = binary == "X" ? "0" * @wide * @high : String.new(binary.to_s)
	end

	def value
		# return the flat string representation of the maze
		return @binary
	end

	def width
		# return logical width
		return (@wide - 1) / 2
	end

	def height
		# return logical height
		return (@high - 1) / 2
	end

	def udlr(str_pos)
		# an array of steps in each direction
		return [up(str_pos), down(str_pos), left(str_pos), right(str_pos)]
	end

	def uuddllrr(str_pos)
		# and array of double steps in each direction
		return [up(up(str_pos)), down(down(str_pos)), left(left(str_pos)), right(right(str_pos))]
	end

	def coordinate(x, y)
		# translate actual coordinates to string position
		x = (x <= (@wide)) ? x : @wide
		x = (x >= 1) ? x : 1
		y = (y <= (@high)) ? y : @high
		y = (y >= 1) ? y : 1
		return (@wide) * (@high - y) + x - 1
	end

	def get_x(str_pos)
		# get the actual x coordinate for a given string position
		x = (str_pos + 1) % @wide
		x = (x==0) ? @wide : x
		return x
	end

	def get_y(str_pos)
		# get the actual y coordinate for a given string position
		return @high - (str_pos) / @wide
	end

	def left(str_pos)
		return coordinate(get_x(str_pos)-1,get_y(str_pos))
	end

	def right(str_pos)
		return coordinate(get_x(str_pos)+1,get_y(str_pos))
	end

	def up(str_pos)
		return coordinate(get_x(str_pos),get_y(str_pos)+1)
	end

	def down(str_pos)
		return coordinate(get_x(str_pos),get_y(str_pos)-1)
	end

	def set(str_pos, val)
		# assign a value to a string position
		@binary[str_pos] = val
	end

	def get(str_pos)
		return @binary[str_pos].to_s
	end
	
	def print(input=@binary)
		# output maze in 2 dimensions
		(1..@high).each do |line|
			puts input[((line-1)*@wide)..((line)*@wide-1)]
		end
	end

	def visualize
		# process the maze string into graphical form
		visual = String.new(@binary)
		(0..((@wide)*(@high)-1)).each do |char|
			if get(char) == "0"
				visual[char] = " "
			else
				horiz = get(left(char)).to_i + get(right(char)).to_i
				vert = get(up(char)).to_i + get(down(char)).to_i
				if (horiz+vert >= 4 || (!is_wall(char) && (horiz >= 1 && vert >= 1)))
					visual[char] = "+"
				elsif horiz >= 2 || vert == 0
					visual[char] = "-"
				else
					visual[char] = "|"
				end
			end
		end
		return visual
	end

	def is_wall(str_pos)
		# check if the 
		return get_x(str_pos)==1 || get_x(str_pos)==@wide || get_y(str_pos)==1 || get_y(str_pos)==@high  
	end

	def redesign
		g = Generator.new(width,height)
		@binary = g.generate.value
	end

end

maze = Maze.new(4,4,111111111100010001111010101100010101101110101100000101111011101100000101111111111)
maze.print(maze.visualize)
gen = Generator.new(4,4)
puts############
maze.redesign
maze.print(maze.visualize)
maze = Maze.new(30,10)
maze.redesign
puts############
maze.print(maze.visualize)
s = Solver.new(maze)
s.trace(1,1,30,10)
puts############
s.print



