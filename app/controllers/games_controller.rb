class GamesController < ApplicationController
	before_action :authenticate_player!

	def new
		@game = Game.new
	end

	def create
		@game = Game.create(game_params)
		redirect_to game_path(@game)
	end

	def show
		@game = Game.where(:id => params[:id]).first
		@pieces = @game.pieces
		if @game.nil?
			redirect_to root_path
		end
	end

	def update
		@game = Game.find(params[:id])
		@game.update_attributes( game_params )
		if @game.valid?
			redirect_to game_path(@game)
		else
			render :text, :status => :unprocessable_entity
		end
	end

	private

	def game_params
		params.require(:game).permit(:name, :white_player_id, :black_player_id )
	end

end

