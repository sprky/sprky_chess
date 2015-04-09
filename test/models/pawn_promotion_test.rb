require 'test_helper'
class PawnPromotionTest < ActiveSupport::TestCase
  test 'white pawn is off board from promotion' do
    game = FactoryGirl.create(:game)
    pawn = FactoryGirl.create(
      :pawn,
      x_position: 1,
      y_position: 7,
      color: true,
      game_id: game.id)
    assert pawn.pawn_promotion(pawn.x_position, pawn.y_position)
    assert_equal nil, pawn.x_position
    assert_equal nil, pawn.y_position
    assert_equal 'Queen', Piece.where(x_position: 1, y_position: 7).last.type
  end

  test 'white pawn can promote' do
    game = FactoryGirl.create(:game)
    pawn = FactoryGirl.create(
      :pawn,
      x_position: 2,
      y_position: 7,
      color: true,
      game_id: game.id)
    Piece.where(x_position: 2, y_position: 7).last.update_attributes(x_position: nil, y_position: nil)
    assert pawn.pawn_can_promote?(pawn.y_position)
  end
end