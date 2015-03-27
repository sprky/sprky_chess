require 'test_helper'

class KingTest < ActiveSupport::TestCase

  test "legal moves" do
    setup_game_and_king

    assert @king.legal_move?(4, 1)
    assert @king.legal_move?(5, 1)
  end

  test "illegal moves" do
    setup_game_and_king

    assert_not @king.legal_move?(6, 0)
    assert_not @king.legal_move?(4, 3)
  end

  test "Should castle kingside" do 
    setup_game_and_king
    setup_castling
  end

  test "Should castle rookside" do 
    setup_game_and_king
    setup_castling
  end

  test "Should fail castling due to obstruction" do 
    setup_game_and_king
    setup_castling

    assert_no_difference('@king.x_position') do 
      @king.castle_move(6, 0)
    end
  end

  def setup_game_and_king
    @game = FactoryGirl.create(:game)
    @king = @game.pieces.find_by(type: 'King', x_position: 4, y_position: 0)
  end

  def setup_castling
    @kings_rook = @game.pieces.find_by(type: 'Rook', x_position: 7, y_position: 0)
    @queens_rook = @game.pieces.find_by(type: 'Rook', x_position: 0, y_position: 0)
  end

end
