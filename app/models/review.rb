class Review < ApplicationRecord
  
	# バリデーション
  validates :content, presence: true

  # アソシエーション
  belongs_to :user
  belongs_to :game
  has_many :comments, dependent: :destroy
  has_many :usefuls, dependent: :destroy
  
  has_one :notification, as: :subject, dependent: :destroy
  
  has_many :reports, foreign_key: "reported_id", as: :reported, dependent: :destroy
  
  # userがreviewusefulしているかどうか確認
  def was_useful_by?(user)
    usefuls.exists?(user_id: user.id)
  end

end
