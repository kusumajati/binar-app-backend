# frozen_string_literal: true

class AddDeletedAtToMaterialQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :material_questions, :deleted_at, :datetime
    add_index :material_questions, :deleted_at
  end
end
