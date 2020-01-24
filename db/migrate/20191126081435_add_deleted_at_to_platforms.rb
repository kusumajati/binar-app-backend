# frozen_string_literal: true

class AddDeletedAtToPlatforms < ActiveRecord::Migration[5.2]
  def change
    add_column :platforms, :deleted_at, :datetime
  end
end
