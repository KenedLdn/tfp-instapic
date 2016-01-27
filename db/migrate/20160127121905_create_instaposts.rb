class CreateInstaposts < ActiveRecord::Migration
  def change
    create_table :instaposts do |t|
      t.text :message
      t.timestamps
    end
  end
end
