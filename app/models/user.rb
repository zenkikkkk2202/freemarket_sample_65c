class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :products
  has_many :credit_cards, dependent: :destroy
  has_many :addresses, dependent: :destroy
  belongs_to :facebook
  belongs_to :google



  # 各項目のバリデーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_VALIDATION = /\A[a-z\d]{7,128}+\z/i

  validates :nickname,              presence: true, length: {maximum: 20}
  validates :email,                 presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password,              presence: true, length: {minimum: 7, maximum: 128},    format: { with: PASSWORD_VALIDATION }
  validates :name_family,           presence: true, length: {maximum: 35}
  validates :name_last,             presence: true, length: {maximum: 35}
  validates :name_kana_f,           presence: true, length: {maximum: 35}
  validates :name_kana_l,           presence: true, length: {maximum: 35}
  validates :birthday_y,            presence: true
  validates :birthday_m,            presence: true
  validates :birthday_d,            presence: true
  validates :encrypted_password,    presence: true
end
