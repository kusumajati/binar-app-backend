# frozen_string_literal: true

module Web::Api::V1::Topics::Entities
  class TopicIncludeChapter < Grape::Entity
    expose :id, expose_nil: false
    expose :title, expose_nil: false
    expose :is_active, expose_nil: false
    expose :chapter, expose_nil: false

    private

    def chapter
<<<<<<< HEAD
      unless object.chapter.nil?
        {
          id: object.chapter.id,
          name: object.chapter.name
        }
      end
=======
      return nil unless object.chapter.present?

      {
        id: object.chapter.id,
        name: object.chapter.name
      }
>>>>>>> 39452e8aba143279eff8a1f3d9e0bb62d4346cf1
    end
  end
end
