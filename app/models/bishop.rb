class Bishop < Piece
	def initialize(args)
		super
		if args[:color] == 1
			write_attribute(:symbol, "white-bishop.gif")
		else
			write_attribute(:symbol, "black-bishop.gif")
		end
	end
end