class SearchesController < ApplicationController
	before_action :user_or_admin?

	def genre_search
		@genres = Genre.all
		genre_id = params[:genre_id]
		@genre = Genre.find(genre_id)
		games = Game.where(genre_id: genre_id)
		@games = games.page(params[:page]).per(8)
	end

	def search
		@records = Game.where('name LIKE ?', "%#{params[:content]}%").page(params[:page]).per(8)
		@genres = Genre.all
	end

end
