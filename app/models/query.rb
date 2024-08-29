class Query < ApplicationRecord
  belongs_to :chat
  has_one :response, dependent: :destroy

  validates :content, presence: true
end
