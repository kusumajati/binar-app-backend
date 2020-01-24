# frozen_string_literal: true

module Mobile::Api::V1::Materials::Entities
  class PlatformMaterial < Grape::Entity
    expose :id
    expose :title
    expose :description
    expose :photo
    expose :chapters, using: Mobile::Api::V1::Materials::Entities::Chapter
  end
end
