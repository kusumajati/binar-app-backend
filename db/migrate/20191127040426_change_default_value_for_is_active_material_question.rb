# frozen_string_literal: true

class ChangeDefaultValueForIsActiveMaterialQuestion < ActiveRecord::Migration[5.2]
  def change
    change_column_default :material_questions, :is_active, from: false, to: true
  end
end
