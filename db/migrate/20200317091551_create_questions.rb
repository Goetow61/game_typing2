class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.text :overview
      t.string :srt, null: false
      t.integer :category, null: false

      t.timestamps
    end
  end
end
