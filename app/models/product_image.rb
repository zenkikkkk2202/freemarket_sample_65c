class ProductImage < ApplicationRecord
  has_one :product, optional: true
end
