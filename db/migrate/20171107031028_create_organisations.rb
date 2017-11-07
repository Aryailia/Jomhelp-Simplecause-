class CreateOrganisations < ActiveRecord::Migration[5.1]
  def change
    create_table :organisations do |t|
    	t.string :name
    	t.string :address
    	t.string :city
    	t.string :postcode
    	t.string :description

		t.timestamps
    end
  end
end
