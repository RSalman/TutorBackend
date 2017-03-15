class UpdateUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_hidden_at, :datetime
    add_index :users, ["phone_number"], unique: true, name: "idx_users_phone_unique"
    remove_column :accepted_tutor_requests, :tutor_review
    remove_column :accepted_tutor_requests, :student_review
  end
end
