class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  
  has_one_attached :profile_image
  
  has_many :favorites,dependent: :destroy
  
  has_many :post_comments,dependent: :destroy
  
  has_many :relationships, class_name: 'Relationship', foreign_key:"followed_id", dependent: :destroy  #followする側
  has_many :followings, through: :relationships, source: :follower #中間テーブルを通して、あるユーザーがフォローしている人と取り出す
  
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key:"follower_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :followed

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50} #23


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
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  # 検索方法分岐
  def self.search_for(search, word)
    if search == "perfect_match" #完全一致
      User.where("name LIKE?", "#{word}") ##whereを使いdbから該当データを取得し、変数に代入
    elsif search == "forward_match" #前方一致
      User.where("name LIKE?","#{word}%") #完全一致以外の検索方法
　　　#{word}の前後(もしくは両方に)、%を追記することで定義することができる
    elsif search == "backward_match" #後方一致
      User.where("name LIKE?","%#{word}")
    elsif search == "partial_match" #部分一致
      User.where("name LIKE?","%#{word}%")
    else
      User.all
    end
  end
  
end
