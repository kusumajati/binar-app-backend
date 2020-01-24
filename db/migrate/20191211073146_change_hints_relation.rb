class ChangeHintsRelation < ActiveRecord::Migration[5.2]
  def change
    remove_column :question_hints, :material_question_id
    add_reference :question_hints, :material_answer, foreign_key: true

  end
end
