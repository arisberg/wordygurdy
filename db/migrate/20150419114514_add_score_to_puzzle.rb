class AddScoreToPuzzle < ActiveRecord::Migration
  def change
    add_column :puzzles, :score, :integer
  end
end
