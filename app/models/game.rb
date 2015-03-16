class Game < ActiveRecord::Base
  after_create :initialize_board!

  has_many :players
  has_many :pieces
  require 'piece'
  


  def initialize_board!
  	#white pawns
  	Pawn.create(:player_id => white_player_id, :game_id => self.id, :x_position => 0, :y_position => 1, :color => 1)
  	Pawn.create(:player_id => white_player_id, :game_id => self.id, :x_position => 1, :y_position => 1, :color => 1)
  	Pawn.create(:player_id => white_player_id, :game_id => self.id, :x_position => 2, :y_position => 1, :color => 1)
  	Pawn.create(:player_id => white_player_id, :game_id => self.id, :x_position => 3, :y_position => 1, :color => 1)
  	Pawn.create(:player_id => white_player_id, :game_id => self.id, :x_position => 4, :y_position => 1, :color => 1)
  	Pawn.create(:player_id => white_player_id, :game_id => self.id, :x_position => 5, :y_position => 1, :color => 1)
  	Pawn.create(:player_id => white_player_id, :game_id => self.id, :x_position => 6, :y_position => 1, :color => 1)
  	Pawn.create(:player_id => white_player_id, :game_id => self.id, :x_position => 7, :y_position => 1, :color => 1)
  	#white rooks
  	Rook.create(:player_id => white_player_id, :game_id => self.id, :x_position => 0, :y_position => 0, :color => 1)
  	Rook.create(:player_id => white_player_id, :game_id => self.id, :x_position => 7, :y_position => 0, :color => 1)
  	#white knights
  	Knight.create(:player_id => white_player_id, :game_id => self.id, :x_position => 1, :y_position => 0, :color => 1)
  	Knight.create(:player_id => white_player_id, :game_id => self.id, :x_position => 6, :y_position => 0, :color => 1)
  	#white bishops
  	Bishop.create(:player_id => white_player_id, :game_id => self.id, :x_position => 2, :y_position => 0, :color => 1)
  	Bishop.create(:player_id => white_player_id, :game_id => self.id, :x_position => 5, :y_position => 0, :color => 1)
  	#white queen and king
  	Queen.create(:player_id => white_player_id, :game_id => self.id, :x_position => 3, :y_position => 0, :color => 1)
  	King.create(:player_id => white_player_id, :game_id => self.id, :x_position => 4, :y_position => 0, :color => 1)

  	#black pawns
  	Pawn.create(:player_id => black_player_id, :game_id => self.id, :x_position => 0, :y_position => 6, :color => 0)
  	Pawn.create(:player_id => black_player_id, :game_id => self.id, :x_position => 1, :y_position => 6, :color => 0)
  	Pawn.create(:player_id => black_player_id, :game_id => self.id, :x_position => 2, :y_position => 6, :color => 0)
  	Pawn.create(:player_id => black_player_id, :game_id => self.id, :x_position => 3, :y_position => 6, :color => 0)
  	Pawn.create(:player_id => black_player_id, :game_id => self.id, :x_position => 4, :y_position => 6, :color => 0)
  	Pawn.create(:player_id => black_player_id, :game_id => self.id, :x_position => 5, :y_position => 6, :color => 0)
  	Pawn.create(:player_id => black_player_id, :game_id => self.id, :x_position => 6, :y_position => 6, :color => 0)
  	Pawn.create(:player_id => black_player_id, :game_id => self.id, :x_position => 7, :y_position => 6, :color => 0)
  	#black rooks
  	Rook.create(:player_id => black_player_id, :game_id => self.id, :x_position => 0, :y_position => 7, :color => 0)
  	Rook.create(:player_id => black_player_id, :game_id => self.id, :x_position => 7, :y_position => 7, :color => 0)
  	#black knights
  	Knight.create(:player_id => black_player_id, :game_id => self.id, :x_position => 1, :y_position => 7, :color => 0)
  	Knight.create(:player_id => black_player_id, :game_id => self.id, :x_position => 6, :y_position => 7, :color => 0)
  	#black bishops
  	Bishop.create(:player_id => black_player_id, :game_id => self.id, :x_position => 2, :y_position => 7, :color => 0)
  	Bishop.create(:player_id => black_player_id, :game_id => self.id, :x_position => 5, :y_position => 7, :color => 0)
  	#black queen and king
  	Queen.create(:player_id => black_player_id, :game_id => self.id, :x_position => 3, :y_position => 7, :color => 0)
  	King.create(:player_id => black_player_id, :game_id => self.id, :x_position => 4, :y_position => 7, :color => 0)
  end

  def capture(destination_x_position, destination_y_position)
    #check if a piece exists at this coordinate
    capture=self.pieces.where(x_position:destination_x_position, y_position:destination_y_position).last
    #if nil do nothing-- if piece, mark as captured and move to (nil, nil)
    capture.update_attribute(:captured?, true)
    capture.update_attribute(:x_position, nil)
    capture.update_attribute(:y_position, nil)
    if capture == nil
      return
    end
  end

end