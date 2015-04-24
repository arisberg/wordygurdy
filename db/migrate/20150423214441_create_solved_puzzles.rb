class CreateSolvedPuzzles < ActiveRecord::Migration
  def change
    create_table :solved_puzzles do |t|
      t.references :user, index: true, foreign_key: true
      t.references :puzzle, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
