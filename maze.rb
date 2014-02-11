require_relative "solver"
require_relative "generator"

class Maze
	# mazes are defined by their width and height
	# this describes a square of spaces that are all open
	# these open spaces can have either walls or paths to other
	# open
	def initialize(wide=1, high=1, binary = "X")
		@wide = wide * 2 + 1
		@high = high * 2 + 1
		@binary = binary == "X" ? "0" * @wide * @high : String.new(binary.to_s)
	end

	def value
		return @binary
	end

	def width
		return (@wide - 1) / 2
	end

	def height
		return (@high - 1) / 2
	end

	def udlr(cell)
		return [up(cell), down(cell), left(cell), right(cell)]
	end

	def uuddllrr(cell)
		return [up(up(cell)), down(down(cell)), left(left(cell)), right(right(cell))]
	end

	def coordinate(x, y)
		# translate logical coordinates to string position
		x = (x <= (@wide)) ? x : @wide
		x = (x >= 1) ? x : 1
		y = (y <= (@high)) ? y : @high
		y = (y >= 1) ? y : 1
		return (@wide) * (@high - y) + x - 1
	end

	def get_x(num)
		x = (num + 1) % @wide
		x = (x==0) ? @wide : x
		return x
	end

	def get_y(num)
		return @high - (num) / @wide
	end

	def left(num)
		return coordinate(get_x(num)-1,get_y(num))
	end

	def right(num)
		return coordinate(get_x(num)+1,get_y(num))
	end

	def up(num)
		return coordinate(get_x(num),get_y(num)+1)
	end

	def down(num)
		return coordinate(get_x(num),get_y(num)-1)
	end

	def set(char, val)
		@binary[char] = val
	end

	def get(char)
		return @binary[char].to_s
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

	def is_wall(cell)
		return get_x(cell)==1 || get_x(cell)==@wide || get_y(cell)==1 || get_y(cell)==@high  
	end

	def redesign
		g = Generator.new(width,height)
		@binary = g.generate.value
	end

end

maze = Maze.new(4,4,111111111100010001111010101100010101101110101100000101111011101100000101111111111)

maze.print(maze.visualize)
gen = Generator.new(4,4)
puts
maze.redesign
maze.print(maze.visualize)
puts
maze = Maze.new(30,10)
maze.redesign
maze.print(maze.visualize)




