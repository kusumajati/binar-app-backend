# frozen_string_literal: true

class CreatePlatforms < ActiveRecord::Migration[5.2]
  def change
    create_table :platforms do |t|
      t.string :name
      t.string :label

      t.timestamps
    end
  end
end
