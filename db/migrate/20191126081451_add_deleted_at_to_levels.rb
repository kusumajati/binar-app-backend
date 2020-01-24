# frozen_string_literal: true

class AddDeletedAtToLevels < ActiveRecord::Migration[5.2]
  def change
    add_column :levels, :deleted_at, :datetime
  end
end
