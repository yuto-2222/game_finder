class Game < ApplicationRecord

	# バリデーション
  validates :name, presence: true,  uniqueness: true
  validates :release_date, presence: true

  # アソシエーション
  has_many :reviews, dependent: :destroy
  belongs_to :genre
  has_many :play_games, dependent: :destroy

  def self.search(keyword)
    where("facility_name LIKE ?", "%#{keyword}%")
  end

  def played_by?(user)
    play_games.exists?(user_id: user.id)
  end


end
