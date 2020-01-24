# frozen_string_literal: true

class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles, id: :uuid do |t|
      t.string :gender
      t.date :birth_date
      t.string :fullname
      t.string :age
      t.string :city
      t.string :province
      t.references :user, type: :uuid, index: { unique: true }, foreign_key: true
      t.string :education
      t.string :occupation
      t.string :industry
      t.string :image

      t.timestamps
    end
  end
end
