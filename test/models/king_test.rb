require 'test_helper'

# Tests specific to King logic
class KingTest < ActiveSupport::TestCase
  test 'Should be legal moves' do
    setup_game_and_king

    assert @king.legal_move?(4, 1)
    assert @king.legal_move?(5, 1)
  end

  test 'Should allow King to move' do
    setup_game_and_king
    Piece.where(x_position: 4, y_position: 1).last.update_attributes(x_position: nil, y_position: nil)
    @king.move_to(@king, x_position: 4, y_position: 1)
    assert_equal 'King', Piece.where(x_position: 4, y_position: 1).last.type
  end

  test 'Should be legal castle move' do
    setup_game_and_king

    assert @king.legal_move?(6, 0)
  end

  test 'Should be illegal moves' do
    setup_game_and_king

    assert_not @king.legal_move?(7, 0)
    assert_not @king.legal_move?(4, 3)
  end

  test 'Should be obstructed move' do
    setup_game_and_king

    assert @king.obstructed_move?(6, 0)
  end

  test 'Should castle kingside' do
    setup_game_and_king
    setup_castling

    assert @king.legal_castle_move?(6, 0)

    @king.castle_move
    @king.reload
    @kings_rook.reload

    assert_equal 6, @king.x_position, 'King moves to castle position'
    assert_equal 5, @kings_rook.x_position, 'Rook moves to castle position'
  end

  test 'Should castle queenside' do
    setup_game_and_king
    setup_castling

    assert @king.legal_castle_move?(2, 0)

    @king.castle_move
    @king.reload
    @queens_rook.reload

    assert_equal 2, @king.x_position, 'King moves to castle position'
    assert_equal 3, @queens_rook.x_position, 'Rook moves to castle position'
  end

  test 'Should return kingside rook' do
    setup_game_and_king
    setup_castling

    assert_equal @kings_rook, @king.rook_for_castling('King')
  end

  test 'Should return queenside rook' do
    setup_game_and_king
    setup_castling

    assert_equal @queens_rook, @king.rook_for_castling('Queen')
  end

  test 'Should return nil for no rook' do
    setup_game_and_king
    setup_castling

    @kings_rook.destroy
    assert_equal nil, @king.rook_for_castling('King')
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
