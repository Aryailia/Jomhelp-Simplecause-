class AddTimeStampsToPosts < ActiveRecord::Migration[5.1]
  def change
  	 add_column :posts, :created_at, :datetime,  default: Time.zone.now, null: false
    add_column :posts, :updated_at, :datetime,  default: Time.zone.now, null: false
  end
end
