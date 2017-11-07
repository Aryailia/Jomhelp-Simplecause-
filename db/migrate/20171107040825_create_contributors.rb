class CreateContributors < ActiveRecord::Migration[5.1]
  def change
    create_table :contributors do |t|
    	t.references :organisation, foreign_key: true
    	t.references :user, foreign_key: true
    	t.integer :role, default: 0

		  t.timestamps
    end
  end
end
