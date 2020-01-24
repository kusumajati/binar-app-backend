# frozen_string_literal: true

module Helpers
  def self.included(base)
    base.instance_eval do
      helpers do
        def permitted_params
          @permitted_params ||= declared(params, include_missing: false)
        end

        def current_user
          resource_owner
        end

        def current_scopes
          current_token.scopes
        end

        def current_token
          doorkeeper_access_token
        end
      end
    end
  end
end
