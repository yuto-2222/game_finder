class ReviewsController < ApplicationController
	before_action :user_or_admin?
	before_action :set_review, only: %i[ show edit update destroy ]

	# GET /reviews or /reviews.json
	def index
		game_id = params[:game_id]
		@game = Game.find(game_id)
		# デフォルトでuseful多い順
		@reviews = @game.reviews.order(created_at: :desc).page(params[:page]).per(8)
	end

	# GET /reviews/1 or /reviews/1.json
	def show
		@game = Game.find(params[:game_id])
		@comment = Comment.new
		# デフォルトで新しい順
		@comments = @review.comments.order(created_at: :desc).page(params[:page]).per(8)
	end

	# GET /reviews/new
	def new
		game_id = params[:game_id]
		@game = Game.find(game_id)
		@review = Review.new
	end

	# POST /reviews or /reviews.json
	def create
		@game = Game.find(params[:game_id])
		@review = Review.new(review_params)
		@review.game_id = @game.id
		@review.user_id = current_user.id
		if @review.save
			flash[:notice] = 'Success !'
			redirect_to game_reviews_path(@game)
		else
			render 'new'
		end
	end

	def edit
		@game = Game.find(params[:game_id])
	end

	def update
		@game = Game.find(params[:game_id])
		if @review.update(review_params)
			flash[:notice] = 'Success !'
			redirect_to game_review_path(@game, @review)
		else
			render 'edit'
		end
	end

	# DELETE /reviews/1 or /reviews/1.json
	def destroy
		@review.destroy
		game = Game.find(params[:game_id])
		reviews = game.reviews
		if reviews.exists?
			redirect_to game_reviews_path(game)
		else
			redirect_to games_path
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_review
			@review = Review.find(params[:id])
		end

		# Only allow a list of trusted parameters through.
		def review_params
			params.require(:review).permit(:content)
		end
end
