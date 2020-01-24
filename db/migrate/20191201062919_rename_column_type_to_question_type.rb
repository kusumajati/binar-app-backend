# frozen_string_literal: true

class RenameColumnTypeToQuestionType < ActiveRecord::Migration[5.2]
  def change
    rename_column :material_questions, :type, :question_type
  end
end
