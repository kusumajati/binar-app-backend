# frozen_string_literal: true

class Configuration < ApplicationRecord
  self.primary_key = 'key'
  validates_presence_of :key
  def self.get(key)
    value = where('key = ?', key).try(:first).try(:value)
    value.present? ? value : ENV[key.to_s.upcase]
  end

  def self.get_or_default(key, default)
    row = find_by(key: key)
    row.present? ? row.value : default
  end
end
