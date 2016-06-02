class AddUserIdColumnToCats < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, :integer
    change_column_null :cats, :user_id, false
    add_index :cats, :user_id
  end
end
