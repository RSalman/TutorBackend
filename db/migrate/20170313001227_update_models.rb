class UpdateModels < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :hidden, :boolean, :default => false, :null => false
    remove_index :courses, name: :index_courses_on_course_prefix_and_course_code
    add_index :courses, ["course_prefix", "course_code"], name: "idx_courses_prefix_code_unique_not_hidden",
              where: "(hidden IS FALSE)"
    add_index :courses, ["course_prefix", "course_code"], name: "idx_courses_prefix_code"
    add_index :courses, :course_code, name: "idx_courses_code"
    remove_foreign_key :tutor_subjects, name: "fk_rails_59086f4d56"
    drop_table :tutor_infos
    remove_column :tutor_subjects, :tutor_info_id
    add_column :tutor_subjects, :user_id, :bigint, :null => false
    remove_index :tutor_subjects, name: :subject_index
    add_index :tutor_subjects, ["user_id", "created_at"], name: "idx_subjects_user_created"
  end
end
