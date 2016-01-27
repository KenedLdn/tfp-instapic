class AlterInstapostsAddUserId < ActiveRecord::Migration
  def change
    add_column :instaposts, :user_id, :integer
    add_index :instaposts, :user_id
  end
end
