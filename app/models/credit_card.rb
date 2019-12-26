class CreditCard < ApplicationRecord
  has_one :user, optional: true
end
