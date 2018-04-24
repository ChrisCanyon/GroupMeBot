class CreateOsrsItems < ActiveRecord::Migration[5.1]
  def change
    create_table :osrs_items do |t|
      t.string :item_name
      t.integer :item_id
      t.integer :store_price

      t.timestamps
    end
  end
end
