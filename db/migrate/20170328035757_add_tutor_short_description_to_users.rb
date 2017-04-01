class AddTutorShortDescriptionToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :tutor_short_description, :string
  end
end