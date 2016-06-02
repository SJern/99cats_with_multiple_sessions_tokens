class RemoveSessionNotNullConstraintFromUsersTable < ActiveRecord::Migration
  def change
    change_column_null :users, :session_token, true
  end
end
