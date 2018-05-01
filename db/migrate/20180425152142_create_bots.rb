class CreateBots < ActiveRecord::Migration[5.1]
  def change
    create_table :bots do |t|
      t.string :bot_id
      t.string :active_commands, array: true, default: [:add_library, :remove_library, :refresh_libraries, :libraries, :active_libraries, :commands]
      t.string :active_libraries, array: true, default: []
      t.integer :group_id

      t.timestamps
    end
  end
end
