# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActionController::RoutingError do |_exception|
    render json: { error: { errors: ["Oh uh Oh you'are lost ??"] } }, status: 404
  end

  def catch_404
    raise ActionController::RoutingError, params[:path]
  end

  def current_user
    User.find(doorkeeper_token[:resource_owner_id])
  end
end
