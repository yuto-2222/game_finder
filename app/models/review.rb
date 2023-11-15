class Review < ApplicationRecord
	# バリデーション
  validates :content, presence: true

  # アソシエーション
  belongs_to :user
  belongs_to :game
  has_many :comments, dependent: :destroy
  has_many :usefuls, dependent: :destroy

  def was_useful_by?(user)
    usefuls.exists?(user_id: user.id)
  end

end
