class InvitationsController < ApplicationController
  before_action :authenticate_player!

  def new
    @invitation = Invitation.new
  end

  def create
    @game = Game.find(params[:game_id])
    @game.invitations.create(invitation_params)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:game_id])
    @invitation = @game
  end

  private

  def invitation_params
    params.require(:invitation).permit(
      :guest_player_email,
      :player_id)
  end
end
