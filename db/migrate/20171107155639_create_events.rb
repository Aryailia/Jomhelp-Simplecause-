class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.timestamp :start_date, null: false
      t.timestamp :end_date,   null: false
      t.float :longitude,      null: false
      t.float :latitude,       null: false
    	t.string :name,          null: false
    	t.string :address,       null: false
    	t.string :city,          null: false
    	t.string :postcode,      null: false
      t.references :organisation, foreign_key: true

      t.timestamps
    end
  end
end
