class Rook < Piece
	def initialize(args)
		super
		if args[:color] == 1
			write_attribute(:symbol, "white-rook.gif")
		else
			write_attribute(:symbol, "black-rook.gif")
		end
	end
end