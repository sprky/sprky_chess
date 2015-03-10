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
		if @game.nil?
			redirect_to root_path
		else
			@pieces = @game.pieces
		end
	end

	def update
		@game = Game.find(params[:id])
		@game.update_attributes( game_params )
		if @game.valid?
			if ensure_unique_players
				randomize_players
			end
			redirect_to game_path(@game)
		else
			render :text, :status => :unprocessable_entity
		end
	end

	private

	def game_params
		params.require(:game).permit(:name, :white_player_id, :black_player_id )
	end

	def ensure_unique_players
		if @game.white_player_id == @game.black_player_id
			@game.update_attributes(black_player_id: nil )
			return false
		else
			return true
		end
	end	

	def randomize_players 
		if rand(0..1)==1
			puts ('swap players')
			temp_id = @game.white_player_id
			@game.update_attributes(white_player_id: @game.black_player_id )
			@game.update_attributes(black_player_id: temp_id)
		end
	end
end
