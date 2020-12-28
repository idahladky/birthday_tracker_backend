class Birthday < ApplicationRecord
  belongs_to :user
  belongs_to :month
end
