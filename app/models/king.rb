class King < Piece
	def initialize(args)
		super
		if args[:color] == 1
			write_attribute(:symbol, "white-king.gif")
		else
			write_attribute(:symbol, "black-king.gif")
		end
	end
end