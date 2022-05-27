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
  has_many :followeds, through: :relationships, source: :follower #中間テーブルを通して、あるユーザーがフォローしている人と取り出す
  
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key:"follower_id", dependent: :destroy
  has_many :followings, through: :reverse_of_relationships, source: :followed

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
  
end
