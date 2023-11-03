class Genre < ApplicationRecord
  #バリデーション
  validates :name, presence: true
  
  # アソシエーション
  has_many :games, dependent: :destroy
end
