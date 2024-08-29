class AddChatIdToResearchPapers < ActiveRecord::Migration[7.2]
  def change
    add_reference :research_papers, :chat, null: false, foreign_key: true
  end
end
