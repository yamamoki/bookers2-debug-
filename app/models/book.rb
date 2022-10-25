class Book < ApplicationRecord
  has_one_attached :image#追加
  belongs_to :user
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
