class ReviewsController < ApplicationController
  before_action :user_or_admin?
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    game_id = params[:game_id]
    @game = Game.find(game_id)
    @reviews = @game.reviews.page(params[:page]).per(8)

  end

  # GET /reviews/1 or /reviews/1.json
  def show
    @game = Game.find(params[:game_id])
    @comment = Comment.new
    @comments = @review.comments.page(params[:page]).per(8)
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
      flash[:success] = "新しいレビューが追加されました！"
      redirect_to game_reviews_path(@game)
    else
      flash.now[:danger] = "レビューの追加に失敗しました。"
      render 'new'
    end
  end


  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy
    redirect_to request.referer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:content, :rating)
    end
end
