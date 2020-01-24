# frozen_string_literal: true

class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :title
      t.references :chapter, foreign_key: true
      t.boolean :is_active
      t.boolean :is_complete

      t.timestamps
    end
  end
end
