# frozen_string_literal: true

class CreatePlatformMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :platform_materials do |t|
      t.string :title
      t.string :description
      t.string :photo
      t.references :platform, foreign_key: true
      t.references :level, foreign_key: true

      t.timestamps
    end
  end
end
