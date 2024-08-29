class CreateQueries < ActiveRecord::Migration[7.2]
  def change
    create_table :queries do |t|
      t.text :content
      t.references :chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
