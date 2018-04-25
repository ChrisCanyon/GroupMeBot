class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.text :requested_feature
      t.integer :user_id

      t.timestamps
    end
  end
end
