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
  has_many :play_games, dependent: :destroy
  has_many :usefuls, dependent: :destroy

  has_one_attached :profile_image

  def self.guest
    find_or_create_by!(email: 'guest@guest.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = 'ゲスト'
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_profile_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image
  end

end
