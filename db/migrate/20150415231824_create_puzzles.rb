class CreatePuzzles < ActiveRecord::Migration
  def change
    create_table :puzzles do |t|
      t.string :clue
      t.string :answer

      t.timestamps null: false
    end
  end
end
