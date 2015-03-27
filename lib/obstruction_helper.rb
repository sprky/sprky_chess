class ObstructionHelper
  def initialize(piece)
    @piece = piece
  end

  def color_name
    color ? 'white' : 'black'
  end
end
