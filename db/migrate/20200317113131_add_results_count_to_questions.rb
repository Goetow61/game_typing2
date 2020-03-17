class AddResultsCountToQuestions < ActiveRecord::Migration[4.2]
  def self.up
    add_column :questions, :results_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :questions, :results_count
  end
end
