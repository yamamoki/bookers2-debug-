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


  def self.search(search, word)
    if search == "forward_match"
                  @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
                  @book = Book.where("title LIKE?","%#{word}")
    elsif search == "perfect_match"
                  @book = Book.where("#{word}")
    elsif search == "partial_match"
                  @book = Book.where("title LIKE?","%#{word}%")
    else
                 @book = Book.all
    end
   end


end