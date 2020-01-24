# frozen_string_literal: true

module Mobile
  module Api
    class Init < Grape::API
      # Create log in console
      insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger,
                   logger: Logger.new(STDERR),
                   filter: Class.new {
                             def filter(opts)
                               opts.reject { |k, _| k.to_s == 'password' }
                                                  end
                           } .new,
                   headers: %w[version cache-control]

      # make phone standar format indonesia
      before do
        if params.phone.present?
          params.phone = Utility.phone_converter(params.phone)
        end
        if params.app_id.present?
          @app = Doorkeeper::Application.where('uid = ?', params.app_id).try(:first)
        end
        error!('Invalid app_id', 401) if @app.blank? && params.app_id.present?
      end

      # Build params using object
      include Grape::Extensions::Hashie::Mash::ParamBuilder

      mount Mobile::Api::V1::Main
    end
  end
end
