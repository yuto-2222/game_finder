class Comment < ApplicationRecord

	# バリデーション
  validates :content, presence: true

  # アソシエーション
  belongs_to :user
  belongs_to :review

  has_one :notification, as: :subject, dependent: :destroy

  has_many :reports, foreign_key: "reported_id", as: :reported, dependent: :destroy

  # 通知関連
  after_create_commit :create_notifications

  private

  def create_notifications
    # Notificationに、レビュー対してコメントがあった際に、userにactionされたことを残す
    Notification.create(subject: self, user: review.user, action: :commented_to_own_review)
  end

end
