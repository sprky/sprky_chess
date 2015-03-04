class Game < ActiveRecord::Base
  has_many :players
  has_many :pieces

  def initialize_board!
  	#white pawns
  	Pawn.new(:player_id => white_player_id, :game_id => self.id, :x_position => 0, :y_position => 1, :color => 1)
  	Pawn.new(:player_id => white_player_id, :game_id => self.id, :x_position => 1, :y_position => 1, :color => 1)
  	Pawn.new(:player_id => white_player_id, :game_id => self.id, :x_position => 2, :y_position => 1, :color => 1)
  	Pawn.new(:player_id => white_player_id, :game_id => self.id, :x_position => 3, :y_position => 1, :color => 1)
  	Pawn.new(:player_id => white_player_id, :game_id => self.id, :x_position => 4, :y_position => 1, :color => 1)
  	Pawn.new(:player_id => white_player_id, :game_id => self.id, :x_position => 5, :y_position => 1, :color => 1)
  	Pawn.new(:player_id => white_player_id, :game_id => self.id, :x_position => 6, :y_position => 1, :color => 1)
  	Pawn.new(:player_id => white_player_id, :game_id => self.id, :x_position => 7, :y_position => 1, :color => 1)
  	#white rooks
  	Rook.new(:player_id => white_player_id, :game_id => self.id, :x_position => 0, :y_position => 0, :color => 1)
  	Rook.new(:player_id => white_player_id, :game_id => self.id, :x_position => 7, :y_position => 0, :color => 1)
  	#white knights
  	Knight.new(:player_id => white_player_id, :game_id => self.id, :x_position => 1, :y_position => 0, :color => 1)
  	Knight.new(:player_id => white_player_id, :game_id => self.id, :x_position => 6, :y_position => 0, :color => 1)
  	#white bishops
  	Bishop.new(:player_id => white_player_id, :game_id => self.id, :x_position => 2, :y_position => 0, :color => 1)
  	Bishop.new(:player_id => white_player_id, :game_id => self.id, :x_position => 5, :y_position => 0, :color => 1)
  	#white queen and king
  	Queen.new(:player_id => white_player_id, :game_id => self.id, :x_position => 3, :y_position => 0, :color => 1)
  	King.new(:player_id => white_player_id, :game_id => self.id, :x_position => 4, :y_position => 0, :color => 1)

  	#black pawns
  	Pawn.new(:player_id => black_player_id, :game_id => self.id, :x_position => 0, :y_position => 6, :color => 0)
  	Pawn.new(:player_id => black_player_id, :game_id => self.id, :x_position => 1, :y_position => 6, :color => 0)
  	Pawn.new(:player_id => black_player_id, :game_id => self.id, :x_position => 2, :y_position => 6, :color => 0)
  	Pawn.new(:player_id => black_player_id, :game_id => self.id, :x_position => 3, :y_position => 6, :color => 0)
  	Pawn.new(:player_id => black_player_id, :game_id => self.id, :x_position => 4, :y_position => 6, :color => 0)
  	Pawn.new(:player_id => black_player_id, :game_id => self.id, :x_position => 5, :y_position => 6, :color => 0)
  	Pawn.new(:player_id => black_player_id, :game_id => self.id, :x_position => 6, :y_position => 6, :color => 0)
  	Pawn.new(:player_id => black_player_id, :game_id => self.id, :x_position => 7, :y_position => 6, :color => 0)
  	#black rooks
  	Rook.new(:player_id => black_player_id, :game_id => self.id, :x_position => 0, :y_position => 7, :color => 0)
  	Rook.new(:player_id => black_player_id, :game_id => self.id, :x_position => 7, :y_position => 7, :color => 0)
  	#black knights
  	Knight.new(:player_id => black_player_id, :game_id => self.id, :x_position => 1, :y_position => 7, :color => 0)
  	Knight.new(:player_id => black_player_id, :game_id => self.id, :x_position => 6, :y_position => 7, :color => 0)
  	#black bishops
  	Bishop.new(:player_id => black_player_id, :game_id => self.id, :x_position => 2, :y_position => 7, :color => 0)
  	Bishop.new(:player_id => black_player_id, :game_id => self.id, :x_position => 5, :y_position => 7, :color => 0)
  	#black queen and king
  	Queen.new(:player_id => black_player_id, :game_id => self.id, :x_position => 3, :y_position => 7, :color => 0)
  	King.new(:player_id => black_player_id, :game_id => self.id, :x_position => 4, :y_position => 7, :color => 0)
  end



end