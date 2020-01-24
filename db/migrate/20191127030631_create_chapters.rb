# frozen_string_literal: true

class CreateChapters < ActiveRecord::Migration[5.2]
  def change
    create_table :chapters do |t|
      t.string :name
      t.references :platform_material, foreign_key: true

      t.timestamps
    end
  end
end
