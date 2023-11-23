class Useful < ApplicationRecord
	
	# アソシエーション
	belongs_to :user
	belongs_to :review
	
	has_one :notification, as: :subject, dependent: :destroy
	
	# 通知関連
	after_create_commit :create_notifications

  private
  
  def create_notifications
  	# Notificationに、レビュー対してusefulされた際に、userにactionされたことを残す
    Notification.create(subject: self, user: self.review.user, action: :useful_to_own_review)
  end

end
