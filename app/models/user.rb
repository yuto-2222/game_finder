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

  def self.guest
    find_or_create_by!(email: 'guest@guest.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = 'ゲスト'
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

end
