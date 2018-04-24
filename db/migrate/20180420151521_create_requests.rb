class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.text :requested_feature

      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
