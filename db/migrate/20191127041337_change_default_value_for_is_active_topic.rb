# frozen_string_literal: true

class ChangeDefaultValueForIsActiveTopic < ActiveRecord::Migration[5.2]
  def change
    change_column_default :topics, :is_active, from: nil, to: true
  end
end
