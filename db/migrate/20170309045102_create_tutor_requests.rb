class CreateTutorRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :tutor_requests do |t|
      t.references :tutor_subject, :null => false
      t.references :user
      t.datetime :matched_at

      t.timestamps
    end

    add_foreign_key :tutor_requests, :tutor_subjects, on_delete: :cascade
    add_foreign_key :tutor_requests, :users, set_null: :cascade
    add_index :tutor_requests, [:user_id, :created_at], :name => 'idx_requests_user_created'
    remove_index :tutor_requests, :user_id
  end
end
