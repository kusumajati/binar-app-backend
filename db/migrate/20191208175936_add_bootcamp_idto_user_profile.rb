class AddBootcampIdtoUserProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :user_profiles, :bootcamp_type, :boolean
    add_column :user_profiles, :deleted_at, :datetime
  end
end
