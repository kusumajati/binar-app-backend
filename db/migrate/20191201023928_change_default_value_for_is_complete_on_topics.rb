# frozen_string_literal: true

class ChangeDefaultValueForIsCompleteOnTopics < ActiveRecord::Migration[5.2]
  def change
    change_column_default :topics, :is_complete, from: nil, to: false
  end
end
