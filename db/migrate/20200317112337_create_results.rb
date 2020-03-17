class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.integer :correct_cnt, null: false
      t.integer :wrong_cnt, null: false
      t.decimal :elapsed_time, null:false, precision:5, scale:1
      t.decimal :speed, null:false, precision:3, scale:1

      t.timestamps
    end
  end
end
