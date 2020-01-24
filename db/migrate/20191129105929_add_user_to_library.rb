# frozen_string_literal: true

class AddUserToLibrary < ActiveRecord::Migration[5.2]
  def change
    add_reference :libraries, :user, type: :uuid, foreign_key: true
  end
end
