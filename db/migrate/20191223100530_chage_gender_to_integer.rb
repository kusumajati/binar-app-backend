class ChageGenderToInteger < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_profiles, :gender
    add_column :user_profiles, :gender, :integer
  end
end
