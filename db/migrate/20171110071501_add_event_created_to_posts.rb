class AddEventCreatedToPosts < ActiveRecord::Migration[5.1]
  def change
  	add_column :posts, :event_created, :boolean, default: false
  	add_column :posts, :event_join, :boolean,  default: false 
  	add_column :posts, :organisation_post, :boolean, default: false
  		
  	end
  end

