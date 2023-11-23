class Game < ApplicationRecord

	# バリデーション
  validates :name, presence: true,  uniqueness: true
  validates :release_date, presence: true

  # アソシエーション
  has_many :reviews, dependent: :destroy
  belongs_to :genre
  has_many :play_games, dependent: :destroy

  has_one_attached :image

  # 並び替えを定義
  scope :latest, -> { order(release_date: :desc) }
  scope :earliest, -> { order(release_date: :asc) }
  scope :popular, -> { order(played_count: :desc) }

  # キーワード検索
  def self.search(keyword)
    where("facility_name LIKE ?", "%#{keyword}%")
  end

  # playedかどうかの確認
  def played_by?(user)
    play_games.exists?(user_id: user.id)
  end

  # GameImage無ければデフォルトを表示
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.png', content_type: 'image/png')
    end
      image
  end

end
