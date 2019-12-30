class Facebook < ApplicationRecord
  belongs_to :user, optional: true
end
