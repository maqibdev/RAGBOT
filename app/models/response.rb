class Response < ApplicationRecord
  belongs_to :query

  validates :content, presence: true
end
