class CreateOrganisations < ActiveRecord::Migration[5.1]
  def change
    create_table :organisations do |t|
      
    	t.string :name,        null: false
    	t.string :address,     null: false
    	t.string :city,        null: false
    	t.string :postcode,    null: false
    	t.string :description, null: false

		t.timestamps
    end
  end
end
