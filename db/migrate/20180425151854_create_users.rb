class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :external_id

      t.timestamps
    end
  end
end
