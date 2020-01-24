# frozen_string_literal: true

class CreateMaterialQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :material_questions do |t|
      t.string :title
      t.text :question
      t.boolean :is_active
      t.references :topic, foreign_key: true
      t.string :question_image
      t.string :type

      t.timestamps
    end
  end
end
