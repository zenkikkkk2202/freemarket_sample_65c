class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true


  POST_CODE_VALID = /\A\d{3}-\d{4}\z/i
  PHONE_NUMBER_CODE_VALID = /\A\d{11}\z/

  # バリデーション
  validates :post_code,               presence: true, length: {maximum: 30}, format: { with: POST_CODE_VALID }
  validates :prefecture_id,           presence: true
  validates :city,                    presence: true, length: {maximum: 50}
  validates :address,                 presence: true, length: {maximum: 50}
  validates :phone_number,            length: {maximum: 30}, uniqueness: { case_sensitive: false }, format: { with: PHONE_NUMBER_CODE_VALID }
end
