class PlayGamesController < ApplicationController

  # 非同期
	def create
    @game = Game.find(params[:game_id])
    play_game = current_user.play_games.new(game_id: @game.id)
    ## 並び替えのためにGameのplayed_countカラムをプラス
    @game.played_count += 1
    @game.save
    play_game.save
	end

	def destroy
    @game = Game.find(params[:game_id])
    play_game = current_user.play_games.find_by(game_id: @game.id)
    ## 並び替えのためにGameのplayed_countカラムをマイナス
    @game.played_count -= 1
    @game.save
    play_game.destroy
	end

end
