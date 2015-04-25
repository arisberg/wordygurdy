class AddRankImageToUser < ActiveRecord::Migration
  def change
    add_column :users, :rankimage, :string
  end
end
