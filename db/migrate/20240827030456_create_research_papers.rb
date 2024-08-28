class CreateResearchPapers < ActiveRecord::Migration[7.2]
  def change
    create_table :research_papers do |t|
      t.string :title

      t.timestamps
    end
  end
end
