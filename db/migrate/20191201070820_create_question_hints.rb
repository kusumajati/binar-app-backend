# frozen_string_literal: true

class CreateQuestionHints < ActiveRecord::Migration[5.2]
  def change
    create_table :question_hints do |t|
      t.text :hint_message
      t.text :appreciate_message
      t.references :material_question, foreign_key: true

      t.timestamps
    end
  end
end
