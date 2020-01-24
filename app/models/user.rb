# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_paranoid
  belongs_to :level, optional: true, foreign_key: :level_id
  belongs_to :role, optional: true, foreign_key: :role_id
  belongs_to :platform, optional: true, foreign_key: :platform_id
  belongs_to :bootcamp, optional: true, foreign_key: :bootcamp_id
  has_one :user_profile
  has_many :student_answers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  delegate :name, :label, to: :role, prefix: true
  validates_uniqueness_of :email,
                          allow_blank: true,
                          case_sensitive: false,
                          message: '%<value>s sudah terdaftar'

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    unless user.blank?
      return user.try(:valid_password?, password) ? user : nil
    end

    nil
  end

  def self.generate_token(user_id, scopes = 'public')
    Doorkeeper::AccessToken.create!(
      application_id: nil,
      resource_owner_id: user_id,
      expires_in: 24.hours,
      use_refresh_token: true,
      scopes: scopes
    )
  end

  def revoke_all_access_tokens!
    Doorkeeper::AccessToken.where(resource_owner_id: id, revoked_at: nil)
                           .update_all(revoked_at: Time.now.utc)
  end

  def self.revoke_token(user_id)
    Doorkeeper::AccessToken
      .where(resource_owner_id: user_id)
      .destroy_all
  end

  def self.get_token(user)
    return nil if user == nil
    self.generate_token(user.id)
  end
end
