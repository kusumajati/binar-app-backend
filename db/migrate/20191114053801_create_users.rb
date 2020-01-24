# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :nickname
      t.string :email
      t.integer :role_id
      t.integer :level_id
      t.integer :platform_id
      t.integer :bootcamp_id
      t.boolean :status
      t.string :user_story

      t.timestamps
    end
  end
end
