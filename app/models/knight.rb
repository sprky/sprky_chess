class Knight < Piece
	def initialize(args)
		super
		if args[:color] == 1
			write_attribute(:symbol, "white-knight.gif")
		else
			write_attribute(:symbol, "black-knight.gif")
		end
	end
end