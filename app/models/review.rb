class Review < ApplicationRecord
	# バリデーション
  validates :content, presence: true

  # アソシエーション
  belongs_to :user
  belongs_to :game
end
