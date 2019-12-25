class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  has_many :products_images, optional: true
end