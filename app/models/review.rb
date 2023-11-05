class Review < ApplicationRecord
	# バリデーション
  validates :content, presence: true
  # validates :rating, numericality: {
  # less_than_or_equal_to: 5,
  # greater_than_or_equal_to: 1}, presence: true


  # アソシエーション
  belongs_to :user
  belongs_to :game
  has_many :comments, dependent: :destroy
end
