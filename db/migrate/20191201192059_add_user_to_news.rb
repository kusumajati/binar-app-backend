class AddUserToNews < ActiveRecord::Migration[5.2]
  def change
    add_reference :news, :user, type: :uuid, foreign_key: true
  end
end
