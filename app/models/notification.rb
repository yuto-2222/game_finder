class Notification < ApplicationRecord

	# アソシエーション
	belongs_to :subject, polymorphic: true
  belongs_to :user

  # 通知をアクションで分岐
  enum action: { commented_to_own_review: 0, useful_to_own_review: 1 }

end
