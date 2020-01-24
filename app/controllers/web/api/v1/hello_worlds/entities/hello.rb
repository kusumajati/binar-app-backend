# frozen_string_literal: true

class Web::Api::V1::HelloWorlds::Entities::Hello < Grape::Entity
  expose :id
  expose :title
end
