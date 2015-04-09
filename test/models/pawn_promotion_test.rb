require 'test_helper'
class PawnPromotionTest < ActiveSupport::TestCase
  test 'white pawn promotion' do
    game = FactoryGirl.create(:game)
    pawn = FactoryGirl.create(
      :pawn,
      x_position: 3,
      y_position: 6,
      color: true,
      game_id: game.id)
    pawn.move_to(pawn, x_position: 3, y_position: 7)
    pawn.reload
    assert_equal nil, pawn.x_position
    assert_equal nil, pawn.y_position
  end
end
