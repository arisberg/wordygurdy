class AddSolvedToPuzzle < ActiveRecord::Migration
  def change
    change_table :puzzles do |t|
        t.boolean :solved
    end
  end
end
