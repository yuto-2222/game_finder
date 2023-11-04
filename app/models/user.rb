class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # バリデーション
  validates :nickname, presence: true,  uniqueness: true
  validates :email, presence: true, format: { with: /\A[a-zA-Z0-9]{1,}[@][a-zA-Z0-9]{1,}[.][a-zA-Z0-9]{1,}\z/ }, uniqueness: true
  validates :password, length: { minimum: 6, maximum: 50 }, on: :create

  # アソシエーション
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

end
