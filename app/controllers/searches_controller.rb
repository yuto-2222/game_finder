class SearchesController < ApplicationController
	before_action :user_or_admin?

	def genre_search
		@genres = Genre.all
		genre_id = params[:genre_id]
		@genre = Genre.find(genre_id)
		games = Game.where(genre_id: genre_id)
		@genre_games = games.all
		# 並び替え方法で分岐
		## latestで新しい順
		if params[:latest] == "true"
			@games = games.latest.page(params[:page]).per(12)
		## earliestで古い順
		elsif params[:earliest] == "true"
			@games = games.earliest.page(params[:page]).per(12)
		## popularで人気順
		elsif params[:popular] == "true"
			@games = games.popular.page(params[:page]).per(12)
		else
			@games = games.all.page(params[:page]).per(12)
		end
	end

	def search
		games = Game.where('name LIKE ?', "%#{params[:content]}%")
		@search_games = games.all
		# 並び替え方法で分岐
		## latestで新しい順
		if params[:latest] == "true"
			@games = games.latest.page(params[:page]).per(12)
		## earliestで古い順
		elsif params[:earliest] == "true"
			@games = games.earliest.page(params[:page]).per(12)
		## popularで人気順
		elsif params[:popular] == "true"
			@games = games.popular.page(params[:page]).per(12)
		else
			@games = games.all.page(params[:page]).per(12)
		end
		@genres = Genre.all
	end

end
