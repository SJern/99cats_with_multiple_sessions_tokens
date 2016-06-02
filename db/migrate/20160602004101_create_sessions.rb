class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id, null: false
      t.string :session_token, null: false
      t.string :environment, null: false
      t.string :location, null: false
      t.timestamps
    end
    add_index :sessions, [:user_id, :session_token]
  end
end
