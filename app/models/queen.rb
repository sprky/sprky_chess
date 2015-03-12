class Queen < Piece
	def initialize(args)
		super
		if args[:color] == 1
			write_attribute(:symbol, "white-queen.gif")
		else
			write_attribute(:symbol, "black-queen.gif")
		end
	end
end