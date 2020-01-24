# frozen_string_literal: true

class CreateLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :libraries do |t|
      t.string :title
      t.string :description
      t.string :library_image
      t.string :library_url
      t.string :library_type
      t.string :author
      t.string :reading_minutes

      t.timestamps
    end
  end
end
