class CreateGroupMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :group_members do |t|
      t.string :external_id
      t.string :old_names, array: true, default: []
      t.string :saved_message_ids, array: true, default: []
      t.string :access_level, default: 'user'

      t.string :name
      t.timestamps
    end
  end
end
