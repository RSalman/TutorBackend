# frozen_string_literal: true
class AddAppTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :app_token, :string
    add_column :users, :app_token_platform, :string
  end
end
