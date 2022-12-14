class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :view_counts, dependent: :destroy #閲覧カウント

  has_many :user_rooms #DMここから
  has_many :chats
  has_many :rooms, through: :user_rooms　#ここまで　   

  has_many :books, dependent: :destroy#追加
  #belongs_to :books
  has_many :book_comments,dependent: :destroy#コメント
  has_many :favorites, dependent: :destroy#いいねで追加

  # フォローをした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # 一覧画面で使用
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_one_attached :profile_image


  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }#追加



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  def self.search(search,word)
    if search == "forward_match"
                 @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
                 @user = User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
                 @user = User.where("#{word}")
    elsif search == "partial_match"
                 @user = User.where("name LIKE?","%#{word}%")
    else
                 @user = User.all
    end
  end
end
