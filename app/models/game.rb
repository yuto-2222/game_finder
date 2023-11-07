class Game < ApplicationRecord
	
	# バリデーション
  validates :name, presence: true,  uniqueness: true
  validates :release_date, presence: true

  # アソシエーション
  has_many :reviews, dependent: :destroy
  belongs_to :genre
  
  def self.search(keyword)
    where("facility_name LIKE ?", "%#{keyword}%")
  end

	
end
