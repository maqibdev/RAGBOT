class Query < ApplicationRecord
  belongs_to :chat
  has_one :response, dependent: :destroy
  has_one :research_paper, dependent: :destroy

  validates :content, presence: true
end
