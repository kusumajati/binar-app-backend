class AddDefaultFalse < ActiveRecord::Migration[5.2]
  def change
    change_column :material_questions, :is_complete, :boolean, default: false
  end
end
