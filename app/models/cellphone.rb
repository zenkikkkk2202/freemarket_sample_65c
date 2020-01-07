class Cellphone < ApplicationRecord
  belongs_to :user, optional: true

  CELLPHONE_NUMBER_CODE_VALID = /\A(070|080|090)-\d{4}-\d{4}\z/
  # バリデーション
  validates :cellphone_number,            uniqueness: { case_sensitive: false }, format: { with: CELLPHONE_NUMBER_CODE_VALID }
end

