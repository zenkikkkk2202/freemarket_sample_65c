class CreditCard < ApplicationRecord
  belongs_to :user, optional: true

  # バリデーション
  validates :card_id,                 presence: true
  validates :customer_id,             presence: true
end
end
