class CreateContributors < ActiveRecord::Migration[5.1]
  def change
    create_table :contributors do |t|
    	t.integer :charity_id, null: false
    	t.integer :user_id, null: false
    	t.integer :role, default: 0

		t.timestamps
    end
  end
end
