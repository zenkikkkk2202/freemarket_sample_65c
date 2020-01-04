class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  # belongs_to :saler, class_name: "User", optional: true, foreign_key: 'user_id'
  # belongs_to :buyer, class_name: "User", optional: true, foreign_key: 'user_id'
  # belongs_to :auction, class_name: "User", optional: true, foreign_key: 'user_id'
  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images, allow_destroy: true
end