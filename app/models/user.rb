class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :sns_credentials, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]


  def self.without_sns_data(auth)
    user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.new(
          nickname: auth.info.name,
          email: auth.info.email,
        )
        sns = SnsCredential.new(
          uid: auth.uid,
          provider: auth.provider
        )
      end
      return { user: user ,sns: sns}
    end

    def self.with_sns_data(auth, snscredential)
    user = User.where(id: snscredential.user_id).first
    unless user.present?
      user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
      )
    end
    return {user: user}
    end

    def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user ,sns: sns}
  end

  # has_many :products
  
  has_many :credit_cards, dependent: :destroy
  has_many :saling_items, -> { where("buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Product"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "saler_id", class_name: "Product"
  has_many :auction_items, -> { where("auction_id is not NULL && buyer_id is NULL") }, foreign_key: "saler_id", class_name: "Product"
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
