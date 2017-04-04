class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :course_prefix, :null => false
      t.string :course_code, :null => false
      t.string :course_name, :null => false
    end

    add_index :courses, [:course_prefix, :course_code], unique: true
  end
end
