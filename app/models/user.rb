class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  # 1人のユーザーは複数のクリエイターを保有している
  has_many :creators, dependent: :destroy
  #親子関係にある関連モデルcreators（子）を作成する。
  accepts_nested_attributes_for :creators

  validates :username, presence: true, length: { maximum: 50 }

end
