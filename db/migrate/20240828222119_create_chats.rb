class CreateChats < ActiveRecord::Migration[7.2]
  def change
    create_table :chats do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
