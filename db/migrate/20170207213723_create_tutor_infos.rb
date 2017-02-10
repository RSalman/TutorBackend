class CreateTutorInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :tutor_infos do |t|
      t.text :description
      t.integer :agg_tutor_rating, :null => false, :default => 0
      t.integer :num_tutor_rating, :null => false, :default => 0
      t.references :user, :null => false

      t.timestamps
    end

    remove_index :tutor_infos, :user_id
    add_foreign_key :tutor_infos, :users, on_delete: :cascade, :unique => true
    add_index :tutor_infos, :user_id, unique: true
  end
end
