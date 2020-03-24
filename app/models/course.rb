class Course < ApplicationRecord
  extend FriendlyId
  belongs_to :year
  has_many :comments
  friendly_id :uniqueslug

  def uniqueslug
    "#{url_name}-#{inner_index}"
  end
end
