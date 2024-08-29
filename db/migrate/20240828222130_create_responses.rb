class CreateResponses < ActiveRecord::Migration[7.2]
  def change
    create_table :responses do |t|
      t.text :content
      t.references :query, null: false, foreign_key: true

      t.timestamps
    end
  end
end
