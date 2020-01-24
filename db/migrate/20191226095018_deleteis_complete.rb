class DeleteisComplete < ActiveRecord::Migration[5.2]
  def change
    remove_column :topics, :is_complete, :boolean
  end
end
