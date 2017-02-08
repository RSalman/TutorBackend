class CreateTutorSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :tutor_subjects do |t|
      t.references :tutor_info, :null => false
      t.references :course, :null => false
      t.integer :rate, :null => false

      t.timestamps
    end

    add_foreign_key :tutor_subjects, :tutor_infos, on_delete: :cascade
    add_foreign_key :tutor_subjects, :courses, on_delete: :cascade
  end
end
