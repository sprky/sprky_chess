class Game < ActiveRecord::Base
  after_create :initialize_board!

  has_many :players
  has_many :pieces

  def initialize_board!
  	#white pawns
    (0..7).each do |i|
      Pawn.create(
        player_id: white_player_id,
        game_id: id,
        x_position: i,
        y_position: 1,
        color: true
        )
    end
  	
  	#white rooks
  	Rook.create(:player_id => white_player_id, :game_id => self.id, :x_position => 0, :y_position => 0, :color => true)
  	Rook.create(:player_id => white_player_id, :game_id => self.id, :x_position => 7, :y_position => 0, :color => true)

  	#white knights
  	Knight.create(:player_id => white_player_id, :game_id => self.id, :x_position => 1, :y_position => 0, :color => true)
  	Knight.create(:player_id => white_player_id, :game_id => self.id, :x_position => 6, :y_position => 0, :color => true)
  	
    #white bishops
  	Bishop.create(:player_id => white_player_id, :game_id => self.id, :x_position => 2, :y_position => 0, :color => true)
  	Bishop.create(:player_id => white_player_id, :game_id => self.id, :x_position => 5, :y_position => 0, :color => true)
  	
    #white queen and king
  	Queen.create(:player_id => white_player_id, :game_id => self.id, :x_position => 3, :y_position => 0, :color => true)
  	King.create(:player_id => white_player_id, :game_id => self.id, :x_position => 4, :y_position => 0, :color => true)

  	#black pawns
    (0..7).each do |i|
      Pawn.create(
        player_id: black_player_id,
        game_id: id,
        x_position: i,
        y_position: 6,
        color: false
        )
    end

  	#black rooks
  	Rook.create(:player_id => black_player_id, :game_id => self.id, :x_position => 0, :y_position => 7, :color => false)
  	Rook.create(:player_id => black_player_id, :game_id => self.id, :x_position => 7, :y_position => 7, :color => false)
  	#black knights
  	Knight.create(:player_id => black_player_id, :game_id => self.id, :x_position => 1, :y_position => 7, :color => false)
  	Knight.create(:player_id => black_player_id, :game_id => self.id, :x_position => 6, :y_position => 7, :color => false)
  	#black bishops
  	Bishop.create(:player_id => black_player_id, :game_id => self.id, :x_position => 2, :y_position => 7, :color => false)
  	Bishop.create(:player_id => black_player_id, :game_id => self.id, :x_position => 5, :y_position => 7, :color => false)
  	#black queen and king
  	Queen.create(:player_id => black_player_id, :game_id => self.id, :x_position => 3, :y_position => 7, :color => false)
  	King.create(:player_id => black_player_id, :game_id => self.id, :x_position => 4, :y_position => 7, :color => false)
  end

  # obstruction?(x, y) method to determine 
  # if an obstruction occurs at this location in this game
  def obstruction?(x, y)
    return self.pieces.where( x_position: x, y_position: y).last
  end
end