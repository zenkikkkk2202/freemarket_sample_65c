class Cellphone < ApplicationRecord
  has_one :user, optional: true
end
