# frozen_string_literal: true

class Platform < ApplicationRecord
  acts_as_paranoid
  has_many :users, foreign_key: :platform_id
  has_many :platform_materials, dependent: :destroy

  validates_presence_of :name, :label, message: 'tidak boleh kosong'
  validates_uniqueness_of :name, :label, case_sensitive: false,
                                         message: '%<value>s sudah terdaftar'
  validates_format_of :name, :label,
                      with: /\A^[a-zA-Z0-9_]+( [a-zA-Z0-9_]+)*$\z/i,
                      allow_blank: true,
                      message: '(%<value>s) tidak valid'
end
