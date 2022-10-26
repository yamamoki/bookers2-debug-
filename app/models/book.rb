class Book < ApplicationRecord
  has_one_attached :image#追加
  belongs_to :user

  has_many :book_comments,dependent: :destroy#コメント
  has_many :favorites, dependent: :destroy#いいね追加

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)#いいね追加
    favorites.where(user_id: user.id).exists?
  end

end
