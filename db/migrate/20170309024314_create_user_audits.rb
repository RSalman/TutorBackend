class CreateUserAudits < ActiveRecord::Migration[5.0]
  def change
    create_table :user_audits do |t|
      t.bigint :user_id, :null => false
      t.string :phone_number, :null => false
      t.string :action, :null => false

      t.timestamps
    end

    add_index :user_audits, [:user_id, :created_at], :name => 'idx_audits_user_created'
    add_index :user_audits, [:phone_number], :name => 'idx_audits_phone'
  end
end
