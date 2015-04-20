class King < Piece
  def castle_move
    # uses instance variables persisted from checking legal_castle_move?
    update_piece(@new_king_x, y_position, 'castled')
    @rook_for_castle.update_piece(@new_rook_x, y_position, 'moved')
  end

  # determine if king can move himself out of check
  def can_move_out_of_check?
    success = false
    ((x_position - 1)..(x_position + 1)).each do |x|
      ((y_position - 1)..(y_position + 1)).each do |y|
        Piece.transaction do
          move_to(x, y) if valid_move?(x, y)
          # if game.check?(color) comes up false,
          # even once, assign  true
          success = true unless game.check?(color)
          # reset any attempted moves
          fail ActiveRecord::Rollback
        end
      end
    end
    success
  end

  def legal_move?(x, y)
    proper_length?(x, y) || legal_castle_move?(x, y)
  end

  # checks for legal castle move to x, y
  def legal_castle_move?(x, y)
    # ensure king hasn't moved yet
    return false unless state == 'unmoved'

    # ensure king moves 2 squares
    return false unless (x - x_position).abs == 2

    # ensure y position doesn't change
    return false unless y == y_position

    # get rook from correct side
    if x > x_position
      # kingside castle
      @rook_for_castle = rook_for_castling('King')
      @new_king_x = 6
      @new_rook_x = 5
    else
      # queenside castle
      @rook_for_castle = rook_for_castling('Queen')
      @new_king_x = 2
      @new_rook_x = 3
    end

    # ensure that we found a rook in the correct location
    return false if @rook_for_castle.nil?

    # make sure rook has not moved
    return false unless @rook_for_castle.state == 'unmoved'

    # otherwise return true
    true
  end

  def move_to(x, y)
    if valid_move?(x, y) && legal_castle_move?(x, y)
      castle_move
    else
      super(x, y)
    end
  end

  def obstructed_squares(x, y)
    x_diff = (x - x_position)

    case x_diff
    when 2
      # move is kingside castle
      rectilinear_obstruction_array(7, y)
    when -2
      # move is queenside castle
      rectilinear_obstruction_array?(0, y)
    else
      # otherwise king moves one space - can't be obstructed - return empty
      return []
    end
  end

  # return the appropriate rook for castling
  # takes 'King' or 'Queen' as an argument
  def rook_for_castling(side)
    case side
    when 'King'
      game.pieces.find_by(
        type: 'Rook',
        x_position: 7,
        y_position: y_position)

    when 'Queen'
      game.pieces.find_by(
        type: 'Rook',
        x_position: 0,
        y_position: y_position)

    else
      return nil
    end
  end

  private

  def proper_length?(x, y)
    x_diff = (x - x_position).abs
    y_diff = (y - y_position).abs

    (x_diff <= 1) && (y_diff <= 1)
  end
end
