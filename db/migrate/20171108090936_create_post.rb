class CreatePost < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|

    	t.references :organisation_id , foreign_key: true
    	t.references :user_id, foreign_key: true

    end
  end
end
