class Pawn < Piece
	def initialize(args)
		super
		if args[:color] == 1
			write_attribute(:symbol, "white-pawn.gif")
		else
			write_attribute(:symbol, "black-pawn.gif")
		end
	end
end