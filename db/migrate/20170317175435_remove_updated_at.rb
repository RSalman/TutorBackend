class RemoveUpdatedAt < ActiveRecord::Migration[5.0]
  def change
    remove_column :tutor_subjects, :updated_at

    change_column :courses, :hidden, :boolean, default: false, null: true
    remove_index :courses, name: :idx_courses_prefix_code_unique_not_hidden
    add_index :courses, ['course_prefix', 'course_code', 'hidden'], name: 'idx_courses_prefix_code_hidden_unique',
        unique: true
  end
end
