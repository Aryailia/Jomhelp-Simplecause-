class AddPhotosToOrganisations < ActiveRecord::Migration[5.1]
  def change
    add_column :organisations, :photos, :json
  end
end
