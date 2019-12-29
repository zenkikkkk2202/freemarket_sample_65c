class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to_active_hash :prefecture
  has_one :user, optional: true
  has_one :user


  POST_CODE_VALID = /\A\d{3}-\d{4}\z/i
  # バリデーション
  validates :post_code,               presence: true, length: {maximum: 30}, format: { with: POST_CODE_VALID }
  validates :prefecture_id,           presence: true
  validates :city,                    presence: true, length: {maximum: 50}
  validates :address,                 presence: true, length: {maximum: 50}
  validates :phone_number,            length: {maximum: 30}, uniqueness: { case_sensitive: false }
end
