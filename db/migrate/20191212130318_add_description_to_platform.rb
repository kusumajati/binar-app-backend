class AddDescriptionToPlatform < ActiveRecord::Migration[5.2]
  def change
    add_column :platforms, :description, :string
  end
end
