class SearchesController < ApplicationController
	before_action :user_or_admin?

	def genre_search
		@genres = Genre.all
		genre_id = params[:genre_id]
		@genre = Genre.find(genre_id)
		games = Game.where(genre_id: genre_id)
		if params[:latest] == "true"
			@games = games.latest.page(params[:page]).per(8)
		elsif params[:earliest] == "true"
			@games = games.earliest.page(params[:page]).per(8)
		elsif params[:popular] == "true"
			@games = games.popular.page(params[:page]).per(8)
		else
			@games = games.all.page(params[:page]).per(8)
		end
	end

	def search
		games = Game.where('name LIKE ?', "%#{params[:content]}%")
		if params[:latest] == "true"
			@games = games.latest.page(params[:page]).per(8)
		elsif params[:earliest] == "true"
			@games = games.earliest.page(params[:page]).per(8)
		elsif params[:popular] == "true"
			@games = games.popular.page(params[:page]).per(8)
		else
			@games = games.all.page(params[:page]).per(8)
		end
		@genres = Genre.all
	end

end
