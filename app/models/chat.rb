class Chat < ApplicationRecord
  belongs_to :user
  has_many :queries, dependent: :destroy
  has_many :research_papers, dependent: :destroy

  validates :title, presence: true
end
