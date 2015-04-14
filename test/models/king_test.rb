require 'test_helper'

# Tests specific to King logic
class KingTest < ActiveSupport::TestCase
  test 'Should be legal moves' do
    setup_game_and_king

    assert @king.legal_move?(4, 1)
    assert @king.legal_move?(5, 1)
  end

  test 'Should be legal castle move' do
    setup_game_and_king

    assert @king.legal_castle_move?(6, 0)
    assert @king.legal_castle_move?(2, 0)
  end

  test 'Should be illegal castle move' do
    setup_game_and_king

    assert_not @king.legal_castle_move?(5, 0)
    assert_not @king.legal_castle_move?(6, 1)

    @king.update_attributes(state: 'moved')
    @king.reload

    assert_not @king.legal_castle_move?(6, 0)
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

  test 'Should allow king normal move' do
    setup_game_and_king

    # remove piece in front of white king
    @game.pieces.find_by(x_position: 4, y_position: 1).destroy

    @king.move_to(@king, x_position: 4, y_position: 1)
    @king.reload

    assert_equal 1, @king.y_position, 'King moved'
    assert_equal 'moved', @king.state, 'King is marked moved'
  end

  # setup new game and find white king
  def setup_game_and_king
    @game = FactoryGirl.create(:game)
    @king = @game.pieces.find_by(type: 'King', x_position: 4, y_position: 0)
  end
end
