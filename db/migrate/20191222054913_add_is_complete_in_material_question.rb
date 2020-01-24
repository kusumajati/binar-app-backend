class AddIsCompleteInMaterialQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :material_questions, :is_complete, :boolean
  end
end
