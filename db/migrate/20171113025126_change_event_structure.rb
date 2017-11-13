class ChangeEventStructure < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :postcode, :place_id
    rename_column :events, :city, :description
  end
end
