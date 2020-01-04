class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :sns_credentials, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_many :products
  
  has_many :credit_cards, dependent: :destroy
  # has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Product"
  # has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Product"
  # has_many :auction_items, -> { where("auction_id is not NULL") }, foreign_key: "saler_id", class_name: "Product"
  has_one :address, dependent: :destroy



  # 各項目のバリデーション
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_VALIDATION = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,128}+\z/i
  NAME_VALIDATION = /\A[一-龥ぁ-ん]+\z/
  KANA_VALIDATION = /\A([ァ-ン]|ー)+\z/

  validates :nickname,              presence: true, length: {maximum: 20}
  validates :email,                 presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password,              presence: true, length: {minimum: 7, maximum: 128},    format: { with: PASSWORD_VALIDATION }
  validates :name_family,           presence: true, length: {maximum: 35},                 format: { with: NAME_VALIDATION }
  validates :name_last,             presence: true, length: {maximum: 35},                 format: { with: NAME_VALIDATION }
  validates :name_kana_f,           presence: true, length: {maximum: 35},                 format: { with: KANA_VALIDATION }
  validates :name_kana_l,           presence: true, length: {maximum: 35},                 format: { with: KANA_VALIDATION }
  validates :birthday_y,            presence: true
  validates :birthday_m,            presence: true
  validates :birthday_d,            presence: true
  validates :encrypted_password,    presence: true
end
