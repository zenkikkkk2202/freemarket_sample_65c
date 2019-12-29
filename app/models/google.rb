class Google < ApplicationRecord
  belongs_to :user, optional: true
end
