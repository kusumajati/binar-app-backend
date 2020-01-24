# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base

    private

    def current_user
      client = Doorkeeper::AccessToken
        .select(:resource_owner_id, :token)
        .find_by(:token => request.params[:token])
      return reject_unauthorized_connection if client.blank?

      client = UserProfile
        .select(:user_id, :id, :role)
        .find_by user_id: client[:resource_owner_id]
    end
  end
end
