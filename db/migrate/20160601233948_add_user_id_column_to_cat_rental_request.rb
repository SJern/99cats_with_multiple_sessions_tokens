class AddUserIdColumnToCatRentalRequest < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer
    change_column_null :cat_rental_requests, :user_id, false
    add_index :cat_rental_requests, :user_id
  end
end
