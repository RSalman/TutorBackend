class SplitRequestsTable < ActiveRecord::Migration[5.0]
  def change
    rename_table('tutor_requests', 'pending_tutor_requests')

    remove_foreign_key :pending_tutor_requests, :users
    change_table :pending_tutor_requests do |t|
      t.remove :matched_at
      t.remove_references :user
      t.references :student
      t.references :tutor
      t.index [:tutor_subject_id, :student_id, :tutor_id], unique: true, name: 'idx_pending_tutor_request'
    end

    create_table :accepted_tutor_requests do |t|
      t.references :tutor_subject, null: false
      t.references :student
      t.references :tutor
      t.timestamps
    end

    add_foreign_key :accepted_tutor_requests, :tutor_subjects, on_delete: :cascade
    add_foreign_key :pending_tutor_requests, :users, column: :student_id, set_null: :cascade
    add_foreign_key :pending_tutor_requests, :users, column: :tutor_id, set_null: :cascade
    add_foreign_key :accepted_tutor_requests, :users, column: :student_id, set_null: :cascade
    add_foreign_key :accepted_tutor_requests, :users, column: :tutor_id, set_null: :cascade
  end
end
