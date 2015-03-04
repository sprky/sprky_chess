class GamesController < ApplicationController

	def new
		@game = Game.new
	end

	def create
		@game = Game.create(game_params)
		redirect_to game_path
	end

	def show
		@game = Game.find(params[:id])
	end

	private

	def game_params
		params.require(:game).permit(:name, :player1, :player2)
	end

end
