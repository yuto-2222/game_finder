class Comment < ApplicationRecord
	# バリデーション
  validates :content, presence: true

  # アソシエーション
  belongs_to :user
  belongs_to :review
  
  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  private
  
  def create_notifications
    Notification.create(subject: self, user: review.user, action: :commented_to_own_review)
  end
  
end
