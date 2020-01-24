# frozen_string_literal: true

class CreateMaterialAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :material_answers do |t|
      t.string :answer
      t.references :material_question, foreign_key: true
      t.boolean :is_correct

      t.timestamps
    end
  end
end
