class AddRefToPuzzles < ActiveRecord::Migration
  def change
    add_reference :puzzles, :user, index: true, foreign_key: true
  end
end
