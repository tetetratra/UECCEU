class Comment < ApplicationRecord
  belongs_to :course
  validates :text, presence: true
end
