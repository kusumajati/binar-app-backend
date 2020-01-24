# frozen_string_literal: true

module Web::Api::V1::Chapters::Entities
  class Chapter < Grape::Entity
    expose :id
    expose :name
<<<<<<< HEAD
    # expose :level, if: lambda { |chapter| !chapter.platform_material.nil? && !chapter.platform_material.level.nil? } do
    #  expose :id do |chapter|
    #    chapter.platform_material.level.id
    #  end
    #  expose :name do |chapter|
    #    chapter.platform_material.level.name
    #  end
    # end
    expose :platform_material, using: Web::Api::V1::Chapters::Entities::Course, as: :course
=======
    expose :platform_material,
           using: Web::Api::V1::Chapters::Entities::Course, as: :course
>>>>>>> 39452e8aba143279eff8a1f3d9e0bb62d4346cf1
    expose :level
    expose :platform

    private

    def level
<<<<<<< HEAD
      if !object.platform_material.nil? && !object.platform_material.level.nil?
        {
          id: object.platform_material.level.id,
          name: object.platform_material.level.name
        }
=======
      unless object.platform_material.blank? ||
             object.platform_material.level.blank?
        level_property(object.platform_material)
>>>>>>> 39452e8aba143279eff8a1f3d9e0bb62d4346cf1
      end
    end

    def level_property(platform_material)
      {
        id: platform_material.level.id,
        name: platform_material.level.name
      }
    end

    def platform
<<<<<<< HEAD
      if !object.platform_material.nil? && !object.platform_material.platform.nil?
        {
          id: object.platform_material.platform.id,
          name: object.platform_material.platform.name,
          label: object.platform_material.platform.label
        }
=======
      unless object.platform_material.blank? ||
             object.platform_material.platform.blank?
        platform_property(object.platform_material.platform)
>>>>>>> 39452e8aba143279eff8a1f3d9e0bb62d4346cf1
      end
    end

    def platform_property(platform)
      {
        id: platform.id,
        name: platform.name,
        label: platform.label
      }
    end
  end
end
