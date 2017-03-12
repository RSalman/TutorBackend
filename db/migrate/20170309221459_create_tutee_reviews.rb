class CreateTuteeReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :tutee_reviews do |t|
      t.references :tutor_request, :null => false
      t.integer :rating, :null => false, :limit => 1
      t.text :review

      t.timestamps
    end

    add_foreign_key :tutee_reviews, :tutor_requests, on_delete: :cascade
  end
end
