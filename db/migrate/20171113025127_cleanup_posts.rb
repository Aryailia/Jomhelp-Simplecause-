class CleanupPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :event_created
    remove_column :posts, :organisation_post
    remove_column :posts, :event_join
  end
end
