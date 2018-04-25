class CreateBots < ActiveRecord::Migration[5.1]
  def change
    create_table :bots do |t|
      t.string :bot_id
      t.string :active_commands, array: true, default: []
      t.integer :group_id

      t.timestamps
    end
  end
end