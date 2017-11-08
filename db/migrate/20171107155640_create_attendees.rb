class CreateAttendees < ActiveRecord::Migration[5.1]
  def change
    create_table :attendees do |t|
      t.references :event, foreign_key: true, null: false
      t.references :user, foreign_key: true,  null: false
      t.boolean :showed_up, default: false,   null: false

      t.timestamps null: false
    end

    # Ensures [event_id, user_id] pairs are unique
    add_index :attendees, [:event_id, :user_id], unique: true
  end
end
