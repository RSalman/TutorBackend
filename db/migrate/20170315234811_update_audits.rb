CREATE_TIMESTAMP = 'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP'
UPDATE_TIMESTAMP = 'DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'

class UpdateAudits < ActiveRecord::Migration[5.0]
  def change
    remove_column :user_audits, :updated_at
    change_column :user_audits, :phone_number, :string, null: false, limit: 15
    change_column :user_audits, :action, :string, null: false, limit: 10
    change_column :user_audits, :created_at, CREATE_TIMESTAMP, null: false

    change_column :courses, :course_prefix, :string, null: false, limit: 10
    change_column :courses, :course_code, :string, null: false, limit: 10
    remove_index :courses, name: :idx_courses_prefix_code_unique_not_hidden
    add_index :courses, ['course_prefix', 'course_code'], name: 'idx_courses_prefix_code_unique_not_hidden',
              where: '(hidden IS FALSE)', unique: true

    add_column :accepted_tutor_requests, :cr_at, CREATE_TIMESTAMP, null: false
    add_column :pending_tutor_requests, :cr_at, CREATE_TIMESTAMP, null: false
    add_index :pending_tutor_requests, ['tutor_id', 'cr_at'], name: 'idx_pending_tutor_cr'
    add_index :pending_tutor_requests, ['student_id', 'cr_at'], name: 'idx_pending_student_cr'
    add_index :accepted_tutor_requests, ['tutor_id', 'cr_at'], name: 'idx_accepted_tutor_cr'
    add_index :accepted_tutor_requests, ['student_id', 'cr_at'], name: 'idx_accepted_student_cr'
    remove_index :pending_tutor_requests, name: :idx_pending_tutor_created
    remove_index :pending_tutor_requests, name: :idx_pending_student_created
    remove_index :accepted_tutor_requests, name: :idx_accepted_tutor_created
    remove_index :accepted_tutor_requests, name: :idx_accepted_student_created
    remove_column :accepted_tutor_requests, :created_at
    remove_column :accepted_tutor_requests, :updated_at
    remove_column :pending_tutor_requests, :created_at
    remove_column :pending_tutor_requests, :updated_at

    remove_column :tutor_subjects, :deleted
    add_column :tutor_subjects, :deleted_at, :datetime
    add_column :tutor_subjects, :cr_at, CREATE_TIMESTAMP, null: false
    add_index :tutor_subjects, ['course_id', 'cr_at'], name: 'idx_subjects_course_cr'
    add_index :tutor_subjects, ['user_id', 'cr_at'], name: 'idx_subjects_user_cr'
    remove_column :tutor_subjects, :created_at
    remove_index :tutor_subjects, name: :index_tutor_subjects_on_course_id
    remove_index :tutor_subjects, name: :idx_subjects_user_created

    change_column :users, :created_at, CREATE_TIMESTAMP, null: false
    change_column :users, :updated_at, UPDATE_TIMESTAMP, null: false
  end
end
