class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites,dependent: :destroy
  has_many :post_comments,dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # 検索方法分岐
  def self.search_for(search, word)
    if search == "perfect_match" #完全一致
     Book.where("title LIKE?","#{word}") #whereを使いdbから該当データを取得し、変数に代入
    elsif search == "forward_match" #前方一致
      Book.where("title LIKE?","#{word}%") #完全一致以外の検索方法は、
#{word}の前後(もしくは両方に)、%を追記することで定義することができる
    elsif search == "backward_match" #後方一致
      Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match" #部分一致
     Book.where("title LIKE?","%#{word}%")
    else
     Book.all
    end
  end
end