class RequestChanges < ActiveRecord::Migration[5.0]
  def change
    add_index :pending_tutor_requests, ["student_id", "created_at"], name: "idx_pending_student_created"
    add_index :pending_tutor_requests, ["tutor_id", "created_at"], name: "idx_pending_tutor_created"
    remove_index :pending_tutor_requests, name: "idx_requests_user_created"
    remove_index :pending_tutor_requests, name: "index_pending_tutor_requests_on_student_id"
    remove_index :pending_tutor_requests, name: "index_pending_tutor_requests_on_tutor_id"
    remove_index :pending_tutor_requests, name: "index_pending_tutor_requests_on_tutor_subject_id"
    add_index :accepted_tutor_requests, ["student_id", "created_at"], name: "idx_accepted_student_created"
    add_index :accepted_tutor_requests, ["tutor_id", "created_at"], name: "idx_accepted_tutor_created"
    remove_index :accepted_tutor_requests, name: "index_accepted_tutor_requests_on_student_id"
    remove_index :accepted_tutor_requests, name: "index_accepted_tutor_requests_on_tutor_id"
    add_column :accepted_tutor_requests, :tutor_rating, :integer, limit: 1
    add_column :accepted_tutor_requests, :tutor_review, :string
    add_column :accepted_tutor_requests, :student_rating, :integer, limit: 1
    add_column :accepted_tutor_requests, :student_review, :string
    add_column :users, :agg_user_rating, :integer, null: false, default: 0
    add_column :users, :num_user_rating, :integer, null: false, default: 0
    add_column :users, :agg_tutor_rating, :integer, null: false, default: 0
    add_column :users, :num_tutor_rating, :integer, null: false, default: 0
    add_column :users, :tutor_hidden, :boolean, default: true, null: false
    add_column :users, :tutor_description, :string
  end
end
