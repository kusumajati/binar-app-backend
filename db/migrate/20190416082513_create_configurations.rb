# frozen_string_literal: true

class CreateConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :configurations, id: false do |t|
      t.string        :key
      t.string        :value
    end
    add_index :configurations, :key
  end
end
