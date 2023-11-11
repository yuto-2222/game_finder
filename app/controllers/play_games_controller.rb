class PlayGamesController < ApplicationController

	def create
    game = Game.find(params[:game_id])
    play_game = current_user.play_games.new(game_id: game.id)
    game.played_count += 1
    game.save
    play_game.save
    redirect_to request.referer
	end

	def destroy
    game = Game.find(params[:game_id])
    play_game = current_user.play_games.find_by(game_id: game.id)
    game.played_count -= 1
    game.save
    play_game.destroy
    redirect_to request.referer
	end

end
