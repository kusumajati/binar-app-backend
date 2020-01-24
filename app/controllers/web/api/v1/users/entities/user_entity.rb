# frozen_string_literal: true

module Web::Api::V1::Users::Entities
  class UserEntity < Grape::Entity
<<<<<<< HEAD
    expose :id, :nickname, :email, :bootcamp_id, :status, :user_story
    expose :role
    expose :level
    expose :platform
    expose :user_profile, using: Web::Api::V1::Users::Entities::UserProfileEntity, as: :profile
=======
    expose :id, expose_nil: false
    expose :nickname, expose_nil: false
    expose :email, expose_nil: false
    expose :status, expose_nil: false
    expose :user_story, expose_nil: false
    expose :user_profile,
           using: Web::Api::V1::Users::Entities::UserProfileEntity,
           as: :profile,
           expose_nil: false
    expose :role, expose_nil: false
    expose :level, expose_nil: false
    expose :platform, expose_nil: false
>>>>>>> 39452e8aba143279eff8a1f3d9e0bb62d4346cf1

    private

    def level
      return unless object.level.present?

      {
        id: object.level.id,
        name: object.level.name
      }
    end

    def platform
<<<<<<< HEAD
      if object.platform.present?
        {
          id: object.platform.id,
          name: object.platform.name,
          label: object.platform.label
        }
      end
    end

    def role
      if object.role.present?
        {
          id: object.role.id,
          name: object.role.name
        }
      end
    end

    def level
      if object.level.present?
        {
          id: object.level.id,
          name: object.level.name
        }
      end
=======
      return unless object.platform.present?

      {
        id: object.platform.id,
        name: object.platform.name,
        label: object.platform.label
      }
    end

    def role
      return unless object.role.present?

      {
        id: object.role.id,
        name: object.role_name
      }
>>>>>>> 39452e8aba143279eff8a1f3d9e0bb62d4346cf1
    end
  end
end
