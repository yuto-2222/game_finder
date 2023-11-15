class UsefulsController < ApplicationController

	def create
    @review = Review.find(params[:review_id])
    useful = current_user.usefuls.new(review_id: @review.id)
    useful.save
	end

	def destroy
    @review = Review.find(params[:review_id])
    useful = current_user.usefuls.find_by(review_id: @review.id)
    useful.destroy
	end

end
