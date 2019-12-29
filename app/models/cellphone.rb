class Cellphone < ApplicationRecord
  belongs_to :user, optional: true
end
