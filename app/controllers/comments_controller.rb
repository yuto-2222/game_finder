class CommentsController < ApplicationController
  before_action :user_or_admin?
  before_action :set_comment, only: %i[ update destroy ]

  # POST /comments or /comments.json
  def create
    @review = Review.find(params[:review_id])
    comment = current_user.comments.new(comment_params)
    comment.review_id = @review.id
    comment.save
    @comments = @review.comments.order(created_at: :desc).page(params[:page]).per(8)
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @review = Review.find(params[:review_id])
    @comment.destroy
    @comments = @review.comments.order(created_at: :desc).page(params[:page]).per(8)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:content)
    end
end
