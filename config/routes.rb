# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper
  # use_doorkeeper
  # main api
  mount Admin::Api::Init, at: '/admin/'
  mount Web::Api::Init, at: '/web/'
  mount Mobile::Api::Init, at: '/mobile/'

  # doc swagger
  mount GrapeSwaggerRails::Engine, as: 'doc_admin_v1', at: 'admin/doc/v1'
  mount GrapeSwaggerRails::Engine, as: 'doc_web_v1', at: 'web/doc/v1'
  mount GrapeSwaggerRails::Engine, as: 'doc_mobile_v1', at: 'mobile/doc/v1'

  # healthcheck endpoint
  get '/health', to: 'healthcheck#index'

  match "*a", to: "application#catch_404", via: :all
end
