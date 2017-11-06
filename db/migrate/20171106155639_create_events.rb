class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.timestamp :start_date
      t.timestamp :end_date
      t.float :longitude
      t.float :latitude
      t.references :organisation, foreign_key: true

      t.timestamps
    end
  end
end
