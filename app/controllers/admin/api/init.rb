# frozen_string_literal: true

module Admin
  module Api
    class Init < Grape::API
      insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger,
                   logger: Logger.new(STDERR),
                   filter: Class.new {
                             def filter(opts)
                               opts.reject { |k, _| k.to_s == 'password' }
                              end
                           } .new,
                   headers: %w[version cache-control]

      # Build params using object
      include Grape::Extensions::Hashie::Mash::ParamBuilder

      # make phone standar format indonesia
      before do
        if params.phone.present?
          params.phone = Utility.phone_converter(params.phone)
        end
      end

      mount Admin::Api::V1::Main
    end
  end
end
