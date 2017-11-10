class CreatePost < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
    	t.references :organisation, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.string :content, null: false
      
      t.timestamps null: false
    end
  end
end
