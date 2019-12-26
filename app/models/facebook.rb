class Facebook < ApplicationRecord
  has_one :user, optional: true
end
