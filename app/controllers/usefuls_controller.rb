class UsefulsController < ApplicationController

  # 非同期
	def create
    @review = Review.find(params[:review_id])
    useful = current_user.usefuls.new(review_id: @review.id)
    ## 並び替えのためにReviewのuseful_countカラムをプラス
    @review.useful_count += 1
    @review.save
    useful.save
	end

	def destroy
    @review = Review.find(params[:review_id])
    useful = current_user.usefuls.find_by(review_id: @review.id)
    ## 並び替えのためにReviewのuseful_countカラムをマイナス
    @review.useful_count -= 1
    @review.save
    useful.destroy
	end

end
