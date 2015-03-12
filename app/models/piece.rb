class Piece < ActiveRecord::Base
  MIN_BOARD_SIZE = 0
  MAX_BOARD_SIZE = 7

  after_initialize :set_default_images

  belongs_to :player
  belongs_to :game

  def valid_move?(x, y)
    move_on_board?(x, y) || !legal_move?(x, y)
  end

  def move_on_board?(x, y)
    x > MAX_BOARD_SIZE || x < MIN_BOARD_SIZE ||
      y > MAX_BOARD_SIZE || y < MIN_BOARD_SIZE
  end

  def legal_move?(x, y)
    raise NotImplementedError "Pieces must implement #move_obstructed?"
  end

  def color_name
    color ? "white" : "black"
  end

  private

  def set_default_images
    self.symbol ||= "#{color_name}-#{type.downcase}.gif"
  end

end
