class Google < ApplicationRecord
  has_one :user, optional: true
end
