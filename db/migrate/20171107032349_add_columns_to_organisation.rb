class AddColumnsToOrganisation < ActiveRecord::Migration[5.1]
  def change
  	add_column :organisations, :email, :string
  end
end
