class Year < ApplicationRecord
  extend FriendlyId
  has_many :courses
  friendly_id :year
end
