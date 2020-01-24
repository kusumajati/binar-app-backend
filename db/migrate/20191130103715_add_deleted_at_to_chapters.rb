# frozen_string_literal: true

class AddDeletedAtToChapters < ActiveRecord::Migration[5.2]
  def change
    add_column :chapters, :deleted_at, :datetime
    add_index :chapters, :deleted_at
  end
end
