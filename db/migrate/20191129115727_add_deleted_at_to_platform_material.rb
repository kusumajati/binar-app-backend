# frozen_string_literal: true

class AddDeletedAtToPlatformMaterial < ActiveRecord::Migration[5.2]
  def change
    add_column :platform_materials, :deleted_at, :datetime
    add_index :platform_materials, :deleted_at
  end
end
