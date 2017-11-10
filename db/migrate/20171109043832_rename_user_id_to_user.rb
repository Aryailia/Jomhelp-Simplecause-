class RenameUserIdToUser < ActiveRecord::Migration[5.1]
  def change
  	rename_column :posts , :user_id_id , :user_id
  	rename_column :posts ,:organisation_id_id , :organisation_id 
  end
end
