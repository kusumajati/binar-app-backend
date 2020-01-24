class AddDeletedAtToMaterialAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :material_answers, :deleted_at, :datetime
    add_index :material_answers, :deleted_at
  end
end
