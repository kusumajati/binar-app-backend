class AddAnswerHistToMaterialQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :material_answers, :answer_hint_id, :integer, foreign_key: true
  end
end
