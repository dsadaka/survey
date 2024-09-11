class CreateResponses < ActiveRecord::Migration[7.2]
  def change
    create_table :responses do |t|
      t.integer :answer
      t.references :question, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
