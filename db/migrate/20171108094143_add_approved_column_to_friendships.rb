class AddApprovedColumnToFriendships < ActiveRecord::Migration[5.1]
  def change
  	add_column :friendships, :approved, :boolean
  end
end
